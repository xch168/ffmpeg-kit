# Android Maven Central 发布指南

本指南介绍如何使用 GitHub Actions 自动构建 FFmpeg Kit Android 库并发布到 Maven Central。

## 功能特性

- 🔨 自动构建 FFmpeg Kit Android 库
- 📦 生成签名的 AAR 文件和源码包
- 🚀 自动发布到 Maven Central
- 📋 生成 Javadoc 文档
- 🏷️ 创建 GitHub Release
- ⚡ 支持手动触发和标签触发

## 环境配置

### 1. Maven Central 账户设置

首先需要在 [Sonatype JIRA](https://issues.sonatype.org/) 注册账户并申请 GroupId `io.github.xch168`。

### 2. GitHub Secrets 配置

在 GitHub 仓库的 Settings > Secrets and variables > Actions 中添加以下密钥：

#### Maven Central 认证
- `MAVEN_CENTRAL_USERNAME`: Sonatype 用户名
- `MAVEN_CENTRAL_PASSWORD`: Sonatype 密码或令牌

#### GPG 签名配置
- `SIGNING_KEY`: GPG 私钥（Base64 编码或原始格式）
- `SIGNING_PASSWORD`: GPG 私钥密码

### 3. GPG 密钥生成

生成 GPG 密钥用于签名：

```bash
# 生成新的 GPG 密钥
gpg --gen-key

# 列出密钥
gpg --list-secret-keys --keyid-format LONG

# 导出私钥（替换 KEY_ID 为你的密钥 ID）
gpg --export-secret-keys KEY_ID | base64

# 导出公钥并上传到密钥服务器
gpg --export KEY_ID | base64
gpg --keyserver hkp://keyserver.ubuntu.com --send-keys KEY_ID
```

## 使用方法

### 方法 1: 通过 Git 标签触发

创建并推送一个版本标签：

```bash
# 创建标签
git tag -a v0.0.1 -m "Release version 0.0.1"

# 推送标签
git push origin v0.0.1
```

支持的标签格式：
- `v*.*.*` (例如: v0.0.1)
- `android-v*.*.*` (例如: android-v0.0.1)

### 方法 2: 手动触发

1. 进入 GitHub 仓库的 Actions 页面
2. 选择 "Android Maven Central Publish" 工作流
3. 点击 "Run workflow"
4. 输入版本号（例如: 0.0.1）
5. 选择是否发布到 Maven Central

## 工作流程

1. **环境准备**: 设置 JDK 17 和 Android SDK
2. **依赖安装**: 安装构建所需的系统依赖
3. **NDK 设置**: 下载并配置 Android NDK
4. **FFmpeg 构建**: 使用项目的构建脚本编译 FFmpeg Kit
5. **Android 库构建**: 生成 AAR 文件和文档
6. **测试执行**: 运行单元测试
7. **发布到 Maven Central**: 签名并上传到 Maven Central
8. **创建 Release**: 在 GitHub 创建发布版本

## 构建输出

构建完成后会生成以下文件：

- `ffmpeg-kit-android-{version}.aar`: 主要的 Android 库文件
- `ffmpeg-kit-android-{version}-sources.jar`: 源码包
- `ffmpeg-kit-android-{version}-javadoc.jar`: Javadoc 文档

## Maven 依赖使用

发布完成后，用户可以在 Android 项目中这样使用：

```gradle
dependencies {
    implementation 'io.github.xch168:ffmpeg-kit-android:0.0.1'
}
```

## 故障排除

### 常见问题

1. **构建失败**: 检查构建日志中的错误信息
2. **签名失败**: 确认 GPG 密钥和密码是否正确
3. **发布失败**: 检查 Maven Central 用户名和密码
4. **NDK 问题**: 确认 NDK 版本兼容性

### 日志查看

- 构建日志会在失败时自动输出
- FFmpeg 构建日志保存在 `build.log`
- 详细错误信息可在 Actions 页面查看

## 许可证

本项目遵循 GNU LESSER GENERAL PUBLIC LICENSE v3 许可证。

## 联系方式

如果遇到问题，请在 GitHub 仓库创建 Issue。 