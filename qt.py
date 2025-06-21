import sys
from pathlib import Path
from collections import deque
from PySide6.QtGui import QImage
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterSingletonType
from PySide6.QtCore import QUrl ,QObject, Signal, Slot, QBuffer, QByteArray ,QTimer
from PySide6.QtLocation import QGeoServiceProvider

import carla_worker
import numpy as np
import time 
import base64
# main.py
import threading
from carla_worker import run_carla_loop
from apis import BackendAPI

backend = BackendAPI()
threading.Thread(target=run_carla_loop, args=(backend,), daemon=True).start()

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    engine.rootContext().setContextProperty("backend", backend)
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)

    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
