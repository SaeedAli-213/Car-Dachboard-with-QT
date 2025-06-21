# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path
from collections import deque
from PySide6.QtGui import QImage
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonType
from PySide6.QtCore import QUrl ,QObject, Signal, Slot, QBuffer, QByteArray ,QTimer
from PySide6.QtLocation import QGeoServiceProvider
import numpy as np
import time 

def carla_to_map_coords(carla_x, carla_y, map_width, map_height, carla_bounds):
    carla_min_x, carla_max_x, carla_min_y, carla_max_y = carla_bounds
    scale_x = map_width / (carla_max_x - carla_min_x)
    scale_y = map_height / (carla_max_y - carla_min_y)
    map_x = (carla_x - carla_min_x) * scale_x
    map_y = map_height - (carla_y - carla_min_y) * scale_y
    return map_x, map_y

class BackendAPI(QObject):
    front_camera_frame_ready = Signal(str)
    soc_signal = Signal(str)
    back_camera_frame_ready = Signal(str)
    vehicle_speed_updated = Signal(float)
    map_image_ready = Signal(str)
    positionChanged = Signal(float, float)
    collision_warning_signal = Signal(str)  # Signal to trigger a warning in QML
    critical_distance_warning_signal = Signal(str)
    CRITICAL_DISTANCE_THRESHOLD = 3.0


    def __init__(self):
        super().__init__()
        self.vehicle = None
        self.front_sensor = None
        self.back_sensor = None
        self.is_running_front = False
        self.is_running_back = False
        self.collision_sensor = None
        self.lidar_sensor = None  # New LIDAR sensor
        self.last_frame_time = time.time()
        self.map_width = 1024
        self.map_height = 1024
        self.carla_bounds = (-200, 200, -200, 200)
        self.timer = QTimer()
        self.timer.timeout.connect(self.update_position)
        self.timer.start(100)
        self.location_x = 0
        self.location_y = 0
        self.front_camera_queue = deque(maxlen=10)  # You can adjust maxlen as needed
        self.back_camera_queue = deque(maxlen=10)
        self.soc = 0
        self.Speed = 0

    @Slot()
    def get_soc(self ):
        self.soc_signal.emit(self.soc)
        
    def set_soc(self , soc_value):
        self.soc = soc_value
    def set_positions(self,  location_x , location_y):
        self.location_x = location_x 
        self.location_y = location_y

    @Slot()
    def update_position(self):
            map_x, map_y = carla_to_map_coords(self.location_x, self.location_y, self.map_width, self.map_height, self.carla_bounds)
            self.positionChanged.emit(map_x, map_y)

    def set_speed(self,speed):
        self.Speed = speed


    @Slot()
    def fetch_vehicle_speed(self):
        print(self.Speed)
        self.vehicle_speed_updated.emit(self.Speed)
    
    @Slot()
    def start_front_camera(self):
        self.is_running_front = True


    @Slot()
    def start_back_camera(self):
        self.is_running_back = True

    def set_camera_frames(self, raw_data, camera_type):
        current_time = time.time()
        if current_time - self.last_frame_time < 0.2:
            return
        self.last_frame_time = current_time

        img = np.array(raw_data)
        img2 = img.reshape((180, 320, 4))
        img3 = img2[:, :, :3]
        img3 = np.ascontiguousarray(img3)

        q_img = QImage(img3.data, 320, 180, QImage.Format_RGB888)

        buffer = QBuffer()
        buffer.open(QBuffer.ReadWrite)
        q_img.save(buffer, "PNG")
        buffer.close()

        base64_data = QByteArray(buffer.data()).toBase64().data().decode("utf-8")
        data_url = f"data:image/png;base64,{base64_data}"
        
        
        if camera_type == "front":
            self.front_camera_queue.append(data_url)
        elif camera_type == "back":
            self.back_camera_queue.append(data_url)
        else:
            print(f"Unknown camera type: {camera_type}")

    @Slot()
    def process_camera_frame(self):

        if self.is_running_front:
            data = self.front_camera_queue.pop()
            self.front_camera_frame_ready.emit(data)

        elif self.is_running_back:
            data = self.back_camera_queue.pop()
            self.back_camera_frame_ready.emit(data)

    
    @Slot()
    def stop_front_camera(self):
        self.is_running_front = False


    @Slot()
    def stop_back_camera(self):
        self.is_running_back = False
    @Slot()
    def capture_topdown_image(self , tawn_name):
            image = "imageurl/tawn_name.jpg" ############################### resolve this ####################
            self.map_image_ready.emit(image)
   

    

