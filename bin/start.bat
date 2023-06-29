@echo off

start javaw -jar -Dfile.encoding=utf-8 -Duser.timezone=GMT+08 -Duser.language=zh -Duser.region=CN ./ms-mcms.jar
:: > boot.log 2>&1
exit