//
//  VirtualObject.swift
//  ARKitInteraction
//
//  Created by Bin on 2017/12/11.
//  Copyright © 2017年 Orz. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

// 渲染模型，虚拟物品
class VirtualObject: SCNReferenceNode {

    var modelName: String {
        return referenceURL.lastPathComponent.replacingOccurrences(of: ".scn", with: "")
    }
    
    // 使用最近虚拟物体距离的平均值来避免物体比例的快速变化。
    private var recentVirtualObjectDistances = [Float]()
    
    func reset() {
        recentVirtualObjectDistances.removeAll()
    }
    
    func setPosition(_ newPosition: float3, relativeTp cameraTransform: matrix_float4x4, smoothMovement: Bool) {
        
        let cameraWorldPostion = cameraTransform.translation
        var positionOffsetFromCamera = newPosition - cameraWorldPostion
        
        if simd_length(positionOffsetFromCamera) > 10 {
            positionOffsetFromCamera = simd_normalize(positionOffsetFromCamera)
            positionOffsetFromCamera *= 10
        }
        
        if smoothMovement {
            let hitTestResultDistance = simd_length(positionOffsetFromCamera)
            
            recentVirtualObjectDistances.append(hitTestResultDistance)
            recentVirtualObjectDistances = Array(recentVirtualObjectDistances.suffix(10))
            
            let averageDistance = recentVirtualObjectDistances.average!
            let averageDistancePosition = simd_normalize(positionOffsetFromCamera) * averageDistance
            simdPosition = cameraWorldPostion + averageDistancePosition
        } else {
            simdPosition = cameraWorldPostion + positionOffsetFromCamera
        }
        
    }
    
    func adjustOntoPlaneAnchor(_ anchor: ARPlaneAnchor, using node: SCNNode) {
        
        // 对象在平面上的坐标系中的位置
        let planePosition = node.convertPosition(position, from: parent)
        
        guard planePosition.y != 0 else { return }
        
        // 在平面的每个角增加10%的容差
        let tolerance: Float = 0.1
        
        let minX: Float = anchor.center.x - anchor.extent.x / 2 - anchor.extent.x * tolerance
        let maxX: Float = anchor.center.x + anchor.extent.x / 2 + anchor.extent.x * tolerance
        let minZ: Float = anchor.center.z - anchor.extent.z / 2 - anchor.extent.z * tolerance
        let maxZ: Float = anchor.center.z + anchor.extent.z / 2 + anchor.extent.z * tolerance
        
        guard (minX...maxX).contains(planePosition.x) && (minZ...maxZ).contains(planePosition.z) else {
            return
        }
    }
    
}

extension VirtualObject {
    
    // 读取所有Models.scnassets文件
    static let availableObjects: [VirtualObject] = {
        let modelsURL = Bundle.main.url(forResource: "Models.scnassets", withExtension: nil)!
        
        let fileEnumerator = FileManager().enumerator(at: modelsURL, includingPropertiesForKeys: [])!
        
        return fileEnumerator.flatMap { element in
            let url = element as! URL
            
            guard url.pathExtension == "scn" else { return nil }
            
            return VirtualObject(url: url)
        }
    }()
    
    static func existingObjectContainingNode(_ node: SCNNode) -> VirtualObject? {
        if let virtualObjectRoot = node as? VirtualObject {
            return virtualObjectRoot
        }
        
        guard let parent = node.parent else { return nil }
        
        return existingObjectContainingNode(parent)
    }
}



extension Collection where Iterator.Element == Float, IndexDistance == Int {
    
    // 返回平均值
    var average: Float? {
        guard !isEmpty else {
            return nil
        }
        
        let sum = reduce(Float(0)) { current, next -> Float in
            return current + next
        }
        
        return sum / Float(count)
    }
}
