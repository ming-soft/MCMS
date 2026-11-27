#!/bin/sh
java -jar -Dfile.encoding=utf-8 -Duser.timezone=GMT+08 -Duser.language=zh -Duser.region=CN ./ms-mcms.jar
# 如需后台运行并输出日志，可使用：
# nohup java -jar -Dfile.encoding=utf-8 -Duser.timezone=GMT+08 -Duser.language=zh -Duser.region=CN ./ms-mcms.jar > boot.log 2>&1 &
