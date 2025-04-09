# Swift-SDK

Swift sdk framework包以及使用说明

# 安装 Swift-sdk

我们提供Swift SDK编译过后的framework包，通过在项目中引入framework包来导入依赖，包名为Eyeofcloud，此Eyeofcloud.framework包为3.10.2版本

# 使用教程

要试用 SDK,请执行以下操作：

1. 在xcode中创建一个新的Storyboard项目 `eyeofcloud-java-quickstart`
2. 将Swift SDK的framework包引入项目中

> ### 在General/Frameworks,Libraries,and Embedded Content中将framework设置为Embed & Sign

3. 将以下代码示例复制到应用到ViewController.swift文件中
4. 将<Your\_SDK\_Key>替换为在上一步中找到的SDK密钥

```
import UIKit
import Eyeofcloud

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let eyeofcloudClient = EyeofcloudClient(sdkKey: "YOUR_SDK_KEY", defaultLogLevel: .error)
        // this Eyeofcloud initialization is asynchronously. for other methods see the Swift SDK reference
        eyeofcloudClient.start { result in
            switch result {
            case .success(let datafile):
                // --------------------------------
                // to get rapid demo results, generate random users. Each user always sees the same variation unless you reconfigure the flag rule.
                // --------------------------------
                var hasOnFlags = false
                
                for _ in 0...9 {
                    let userId = String(Int.random(in: 1000...9999))
                    // --------------------------------
                    // Create hardcoded user & bucket user into a flag variation
                    // --------------------------------
                    let user = eyeofcloudClient.createUserContext(userId: userId)
                    // "product_sort" corresponds to a flag key in your Eyeofcloud project
                    let decision = user.decide(key: "product_sort")
                    // did decision fail with a critical error?
                    if decision.variationKey == nil || decision.variationKey == "" {
                        print("decision error: \(decision.reasons)" )
                    }
                    // get a dynamic configuration variable
                    // "sort_method" corresponds to a variable key in your Eyeofcloud project
                    let sortMethod: String? = decision.variables.getValue(jsonPath: "sort_method")
                                        
                    // always returns false until you enable a flag rule in your Eyeofcloud project
                    if decision.enabled {
                        // Keep count how many visitors had the flag enabled
                        hasOnFlags = true
                    }
                    
                    // --------------------------------
                    // Mock what the users sees with print statements (in production, use flag variables to implement feature configuration)
                    // --------------------------------
                    print("\n\nFlag \(decision.enabled ? "on" : "off"). User number \(user.userId) saw flag variation: \(decision.variationKey ?? "") and got products sorted by: \(String(describing: sortMethod!)) config variable as part of flag rule: \(decision.ruleKey ?? "")")
                }
                
                if !hasOnFlags {
                    var projectId: Any?
                    if let config: Any = try? JSONSerialization.jsonObject(with: datafile, options: []), let convertedDict = config as? [String: Any] {
                        projectId = convertedDict["projectId"]
                    }
                    
                    print("\n\nFlag was off for everyone. Some reasons could include:\n1. Your sample size of visitors was too small. Rerun, or increase the iterations in the FOR loop\n2. Check your SDK key. Verify in Settings>Environments that you used the right key for the environment where your flag is toggled to ON.\ncheck your key at  https://app.eyeofcloud.com/v2/projects/\(String(describing: projectId!))/settings/implementation")
                }
            case .failure(_):
                print("Eyeofcloud client invalid. Verify in Settings>Environments that you used the primary environment's SDK key")
            }
        }
    }
}
```
5. 运行程序在控制台查看结果

# 演示示例

本SDK附带一个SwiftUI类型的演示示例
