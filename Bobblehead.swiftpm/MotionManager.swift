import CoreMotion
import Foundation

class MotionManager {
    private var motionManager = CMHeadphoneMotionManager()
    var pitch = 0.0
    var roll = 0.0
    var yaw = 0.0
    var accelx = 0.0;
    var accely = 0.0;
    var accelz = 0.0;
    
    init()  {
        motionManager.startDeviceMotionUpdates(to: OperationQueue()) {[weak self] motion, error in
            guard let self = self, let motion = motion else {return}
            self.pitch = motion.attitude.pitch
            self.roll = motion.attitude.roll
            self.yaw = motion.attitude.yaw
            
            self.accelx = motion.userAcceleration.x
            self.accely = motion.userAcceleration.y
            self.accelz = motion.userAcceleration.z
        }
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}
