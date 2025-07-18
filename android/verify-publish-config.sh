#!/bin/bash

echo "=== FFmpeg Kit Android 发布配置验证 ==="
echo ""

# 检查版本配置
echo "1. 版本配置:"
if [ -f "gradle.properties" ]; then
    echo "   gradle.properties 中的版本:"
    grep "version=" gradle.properties || echo "   未找到版本配置"
else
    echo "   gradle.properties 文件不存在"
fi
echo ""

# 检查环境变量
echo "2. 环境变量:"
echo "   MAVEN_CENTRAL_USERNAME: ${MAVEN_CENTRAL_USERNAME:+已设置}"
echo "   MAVEN_CENTRAL_PASSWORD: ${MAVEN_CENTRAL_PASSWORD:+已设置}"
echo "   SIGNING_KEY: ${SIGNING_KEY:+已设置}"
echo "   SIGNING_PASSWORD: ${SIGNING_PASSWORD:+已设置}"
echo ""

# 检查 Gradle 配置
echo "3. Gradle 配置:"
if [ -f "ffmpeg-kit-android-lib/build.gradle" ]; then
    echo "   build.gradle 文件存在"
    echo "   发布端点: https://central.sonatype.com/api/v1/publisher"
else
    echo "   build.gradle 文件不存在"
fi
echo ""

# 运行 Gradle 测试任务
echo "4. 运行 Gradle 测试任务:"
./gradlew testPublishConfig || echo "   测试任务执行失败"
echo ""

echo "=== 验证完成 ===" 