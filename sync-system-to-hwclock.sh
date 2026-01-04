# 系统时间同步到硬件时钟脚本（每5分钟执行）
# 日志路径
LOG_FILE="/var/log/hwclock-sync.log"
# 时间戳格式
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# 1. 检查hwclock命令是否存在
if ! command -v hwclock &> /dev/null; then
    echo "[$TIMESTAMP] 错误：未找到hwclock命令（需安装util-linux包）" >> $LOG_FILE
    exit 1
fi

# 2. 执行同步（--systohc：system to hardware clock）
hwclock --systohc
if [ $? -eq 0 ]; then
    echo "[$TIMESTAMP] 系统时间同步到硬件时钟成功" >> $LOG_FILE
else
    echo "[$TIMESTAMP] 错误：系统时间同步到硬件时钟失败" >> $LOG_FILE
    exit 1
fi
