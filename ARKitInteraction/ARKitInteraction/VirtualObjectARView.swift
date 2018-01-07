//
//  VirtualObjectARView.swift
//  ARKitInteraction
//
//  Created by Bin on 2017/12/11.
//  Copyright © 2017年 Orz. All rights reserved.
//

import UIKit
import ARKit

// 虚拟物品的ARView
// 添加虚拟物品时先进行测试？
// 相当于第二层 Scence Understanding（场景理解），平面检测、命中测试、光线估算
class VirtualObjectARView: ARSCNView {

    // MARK: - Type
    
    struct HitTestRay {
        // float3: x, y, z
        var origin: float3
        var direction: float3 // 方向
        
        // 在平面的水平方向上的相交点
        func intersectionWithHorzontalPlane(atY planeY: Float) -> float3? {
            
            let normalizedDirection = simd_normalize(direction)
            
            // Special case handling: Check if the ray is horizontal as well.
            // 检查光线是否水平
            if normalizedDirection.y == 0 {
                if origin.y == planeY {
                    /*
                     The ray is horizontal and on the plane, thus all points on the ray
                     intersect with the plane. Therefore we simply return the ray origin.
                     射线是水平的，在平面上，因此射线上的所有点与平面相交。 因此，我们只需返回射线的来源。
                     */
                    return origin
                } else {
                    // 光线平行于平面，没有相交。
                    return nil
                }
            }
            
            // 光线的原点到水平面上的交点距离
            let distance = (planeY - origin.y) / normalizedDirection.y
            
            if distance < 0 {
                return nil
            }
            
            // 返回交点
            return origin + (normalizedDirection * distance)
            
        }
    }
    
    struct FeatureHitTestResult {
        var position: float3
        var distanceToRayOrigin: Float
        var featureHit: float3
        var featureDistanceToHitResult: Float
        
    }
    
    // MARK: Position Testing
    func virtualObject(at point: CGPoint) -> VirtualObject? {
        let hitTestOptions: [SCNHitTestOption: Any] = [SCNHitTestOption.boundingBoxOnly: true]
        
        let hitTestResults = hitTest(point, options: hitTestOptions)
        
        return hitTestResults.lazy.flatMap { result in
            return VirtualObject.existingObjectContainingNode(result.node)
        }.first
    }
    
}


















