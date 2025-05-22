# This Python file uses the following encoding: utf-8
import sys
from pathlib import Path

from PySide6.QtGui import QImage
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonType
from PySide6.QtCore import QUrl ,QObject, Signal, Slot, QBuffer, QByteArray ,QTimer
from PySide6.QtLocation import QGeoServiceProvider


import numpy as np
import time
import base64

def carla_to_map_coords(carla_x, carla_y, map_width, map_height, carla_bounds):
    carla_min_x, carla_max_x, carla_min_y, carla_max_y = carla_bounds
    scale_x = map_width / (carla_max_x - carla_min_x)
    scale_y = map_height / (carla_max_y - carla_min_y)
    map_x = (carla_x - carla_min_x) * scale_x
    map_y = map_height - (carla_y - carla_min_y) * scale_y
    return map_x, map_y



class APIS(QObject):
    front_camera_frame_ready = Signal(str)
    update_soc = Signal(float)
    back_camera_frame_ready = Signal(str)
    vehicle_speed_updated = Signal(float)
    map_image_ready = Signal(str)
    positionChanged = Signal(float, float)
    collision_warning_signal = Signal(str)  # Signal to trigger a warning in QML
    critical_distance_warning_signal = Signal(str)
    CRITICAL_DISTANCE_THRESHOLD = 3.0


    def _init_(self):
        super()._init_()
        self.location_x = 0
        self.location_y = 0
        self.speed = 0
        self.soc =0
        self.vehicle = None
        self.front_sensor = None
        self.back_sensor = None
        self.is_running_front = False
        self.is_running_back = False
        self.last_frame_time = time.time()
        self.map_width = 1024
        self.map_height = 1024
        self.carla_bounds = (-200, 200, -200, 200)
        self.timer = QTimer()
        self.timer.timeout.connect(self.update_position)
        self.timer.start(100)
    



    
    # from battery model
    def set_soc(self,soc) : 
        self.soc = soc
    @Slot
    def get_soc(self):
        self.update_soc.emit(self.soc)
    
    # from carla
    def set_positions(self,location_x, location_y):
        self.location_x = location_x
        self.location_y = location_y

    @Slot
    def update_position(self):
            map_x, map_y = carla_to_map_coords(self.location_x, self.location_y, self.map_width, self.map_height, self.carla_bounds)
            self.positionChanged.emit(map_x, map_y)


    # from carla
    def set_speed(self,speed) : 
        self.speed = speed
    @Slot()
    def fetch_vehicle_speed(self):
        self.vehicle_speed_updated.emit(self.speed)


    @Slot()
    def start_front_camera(self):
        self.is_running_front = True


    @Slot()
    def start_back_camera(self):
        self.is_running_back = True


    def process_camera_frame(self, raw_data, camera_type):

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

        if camera_type == "front" and self.is_running_front:
            self.front_camera_frame_ready.emit(data_url)
        elif camera_type == "back" and self.is_running_back:
            self.back_camera_frame_ready.emit(data_url)

    
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

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    qmlRegisterSingletonType(QUrl.fromLocalFile("Style.qml"), "Style", 1, 0, "Style")

    qml_file = Path(__file__).resolve().parent / "main.qml"



    #backend = APIS()
    #engine.rootContext().setContextProperty("backend", backend)

    engine.load(qml_file)
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
