# JumpServer Web STATIC

JumpServer Web 项目，包含一些静态安装包文件

## Docker 构建

```bash
VERSION=dev
docker buildx build --build-arg VERSION=${VERSION} -t jumpserver/web-static:${VERSION} . --load
```
