TOOLCHAIN:=/opt/4.9-2014q4

BSP=STM32F4-Discovery
HAL=STM32F4xx_HAL_Driver
OUTDIR=build/${CFG}
TARGET_BIN=fc.bin
LINKER_SCRIPT=STM32F407VG_FLASH.ld

CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
LD = ${CC}

ARCH_FLAGS=-mcpu=cortex-m4 -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16 -g
LDFLAGS=$(ARCH_FLAGS) -Wl,--gc-sections,-Map,$(OUTDIR)/$(basename $(TARGET_BIN)).map -T $(LINKER_SCRIPT)
CFLAGS=$(ARCH_FLAGS) -flto -ffunction-sections -fdata-sections -Wall -DSTM32F407xx
INCS=-I.

TARGET=$(basename $(TARGET_BIN)).elf

SRCS := $(wildcard *.c)


include bsp/$(BSP)/sources
include hal/$(HAL)/sources
include hal/cmsis/sources

OUTDIRS=$(addprefix $(OUTDIR)/, $(MKDIR))

$(OUTDIR)/%.bin: $(OUTDIR)/%.elf
	$(OBJCOPY) -O binary $< $@  

$(OUTDIR)/%.o: %.s
	$(CC) $(CFLAGS) $(INCS) -o $@ -c $<

$(OUTDIR)/%.o: %.c
	$(CC) $(CFLAGS) $(INCS) -o $@ -c $<

$(OUTDIRS):
	@mkdir -p $(OUTDIRS)

OBJS := $(SRCS:.c=.o)
OBJS := $(OBJS:.s=.o)
OBJS := $(addprefix ./$(OUTDIR)/,$(OBJS))


$(OUTDIR)/$(TARGET): $(OBJS) $(LINKER_SCRIPT)
	$(LD) -o $@ $(OBJS) $(LDFLAGS)

all:	$(OUTDIRS) $(OUTDIR)/$(TARGET) $(OUTDIR)/$(TARGET_BIN)
clean:
	rm -rf $(OUTDIR)
	make all

.DEFAULT_GOAL=all

