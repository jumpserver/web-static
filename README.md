# JumpServer Web STATIC

JumpServer Web 项目，包含一些静态安装包文件

## Docker 构建

```bash
VERSION=$(cat VERSION)
./prepare.sh
docker buildx build -t jumpserver/web-static:${VERSION} . --load
```
