
import carla_worker
import time
import carla

def run_carla_loop(backend):
    client = carla.Client("localhost", 2000)
    client.set_timeout(10.0)
    world = client.get_world()

    blueprint_library = world.get_blueprint_library()
    vehicle_bp = blueprint_library.filter('vehicle.*')[0]
    spawn_point = world.get_map().get_spawn_points()[75]

    vehicle = world.spawn_actor(vehicle_bp, spawn_point)
    vehicle.set_autopilot(True)
    
    while True:
        transform = vehicle.get_transform()
        velocity = vehicle.get_velocity()
        print(velocity)

        speed = (velocity.x**2 + velocity.y**2 + velocity.z**2)**0.5 * 3.6  # in km/h

        backend.set_speed(speed)
        backend.set_positions(transform.location.x, transform.location.y)
        backend.set_soc("85%")  
        time.sleep(0.1)
