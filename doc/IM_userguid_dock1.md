# 集成IOS SDK前的准备工作
## 注册开发者账号并且创建后台应用
详细操作步骤见开发者注册及管理后台

## 制作并上传推送证书

如果不需要实现离线推送功能，请忽略这步

step1. 打开苹果开发者网站

![Alt one](1.gif)

step2. 从Member Center进入Certificates, Identifiers & Profiles

![Alt two](2.gif)

step3. 选择要制作的推送证书

![Alt three](3.gif)

* 对于开发环境(sandbox)的推送证书, 请选择 Apple Push Notification service SSL (Sandbox) 
* 对于生产环境(production)的推送证书, 请选择 Apple Push Notification service SSL (Production)

step4. 选择对应的APP ID 
 ![Alt four](4.gif)

step5. 根据Certificate Assistant的提示, 创建Certificate Request 

![Alt five](5.gif)

step6. 上传上一步中创建的Certificate Request文件

![Alt six](6.gif)

step7. 上传完毕后, 推送证书就被正确生成了, 之后我们下载下来这个证书, 并双击导入系统
 
 ![Alt seven](7.gif)  

## 上传推送证书

step1. 打开Application –> Utilities –> Keychain Access应用, 我们会看到有刚刚我们制作好的推送证书

step3. 登录管理后台

step4. 输入了正确的账号后, 选择对应的APP

step5. 填写的证书名称 

这个名称是个有意义的名字, 对推送直接相关, 稍后会在源码的修改里继续用到这个名字. 上传之前导出的P12文件, 密码则为此P12文件的密码, 证书类型请根据具体情况选择 

创建的是Apple Push Notification service SSL Sandbox请选择开发环境; Apple Push Notification service SSL Production请选择生产环境) 

step6. 上传 

请注意正确选择是生产环境还是测试环境的证书
