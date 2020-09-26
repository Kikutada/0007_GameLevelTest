//
//  GameMain.swift
//  0004_PlayerTest
//
//  Created by Kikutada on 2020/08/17.
//  Copyright © 2020 Kikutada All rights reserved.
//

import SpriteKit

/// Main sequence of game scene.
class CgGameMain : CgSceneFrame {

    private var scene_attractMode: CgSceneAttractMode!
    private var scene_maze: CgSceneMaze!
    private var scene_deposit: CgSceneDeposit!
    private var attarctMode: Int = 0

    init(skscene: SKScene) {
        super.init()

        // Create SpriteKit managers.
        self.sprite = CgSpriteManager(view: skscene, imageNamed: "pacman16_16.png", width: 16, height: 16, maxNumber: 64)
        self.background = CgCustomBackgroundManager(view: skscene, imageNamed: "pacman8_8.png", width: 8, height: 8, maxNumber: 2)
        self.sound = CgSoundManager(binding: self, view: skscene)
        self.context = CgContext()

        scene_attractMode = CgSceneAttractMode(object: self)
        scene_maze = CgSceneMaze(object: self)
        scene_deposit = CgSceneDeposit(object: self)
    }

    /// Event handler
    /// - Parameters:
    ///   - sender: Message sender
    ///   - id: Message ID
    ///   - values: Parameters of message
    override func handleEvent(sender: CbObject, message: EnMessage, parameter values: [Int]) {
        if message == .Touch {
            if getSequence() == 0 || getSequence() == 2 {
                goToNextSequence()
            }
        }
    }

    /// Handle sequence
    /// To override in a derived class.
    /// - Parameter sequence: Sequence number
    /// - Returns: If true, continue the sequence, if not, end the sequence.
    override func handleSequence(sequence: Int) -> Bool {
        
        switch sequence {
            case  0:
                switch attarctMode {
                    case 0:
                        scene_attractMode.resetSequence()
                        scene_attractMode.startSequence()
                        attarctMode = 1
                    case 1:
                        if !scene_attractMode.enabled {
                            context.demo = true
                            sound.enableOutput(false)
                            scene_maze.resetSequence()
                            scene_maze.startSequence()
                            attarctMode = 2
                        }
                    case 2:
                        if !scene_maze.enabled {
                            attarctMode = 0
                        }
                    default:
                        break
                }


            case 1:
                context.demo = false
                if scene_attractMode.enabled {
                    scene_attractMode.stopSequence()
                    scene_attractMode.clear()
                }
                if scene_maze.enabled {
                    scene_maze.stopSequence()
                    scene_maze.clear()
                }

                context.credit += 1
                scene_deposit.resetSequence()
                scene_deposit.startSequence()
                sound.enableOutput(true)
                sound.playSE(.Credit)
                goToNextSequence()
                
            case 2:
                // Forever loop
                break

            case 3:
                context.credit -= 1
                scene_deposit.stopSequence()
                scene_maze.resetSequence()
                scene_maze.startSequence()
                goToNextSequence()
                
            case 4:
                if !scene_maze.enabled {
                    attarctMode = 0
                    goToNextSequence(0)
                }

            default:
                // Forever loop
                break
        }
        
        // Continue running sequence.
        return true
    }

}

/// CgCustomBackground creates animation textures by overriden extendTextures function.
class CgCustomBackgroundManager : CgBackgroundManager {
    
    /// String color for background
    /// Raw value is offset of colored alphabet.
    enum EnBgColor: Int {
        case White = 0
        case Red = 64
        case Purple = 128
        case Cyan = 192
        case Orange = 256
        case Yellow = 320
        case Pink = 384
        case Character = 512
        case Maze = 576
        case Blink = 640
    }

    override func extendTextures() -> Int {
        // Blinking power dot
        // Add its texture as #16*48.
        extendAnimationTexture(sequence: [595, 592], timePerFrame: 0.16)

        // Blinking "1" character
        extendAnimationTexture(sequence: [17, 0], timePerFrame: 0.26)
        
        // Blinking "U" character
        extendAnimationTexture(sequence: [53, 0], timePerFrame: 0.26)
        
        // Blinking "P" character
        extendAnimationTexture(sequence: [48, 0], timePerFrame: 0.26)

        return 4 // Number of added textures
    }
    
    /// Print string with color on a background at the specified position.
    /// - Parameters:
    ///   - number: Background control number between 0 to (maxNumber-1)
    ///   - color: Specified color
    ///   - column: Column coordinate for position
    ///   - row: Row coordinate for position
    ///   - string: String corresponded to texture numbers
    ///   - offset: Offset to add to texture number
    func print(_ number: Int, color: EnBgColor, column: Int, row: Int, string: String ) {
        let asciiOffset: Int = 16*2  // for offset of ASCII
        putString(number, column: column, row: row, string: string, offset: color.rawValue-asciiOffset)
    }
}
