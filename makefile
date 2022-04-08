DIR_ROOT 	:= .
DIR_BUILD 	:= $(DIR_ROOT)/build
DIR_SRC		:= $(DIR_ROOT)/src
AS_FILES	:= $(wildcard $(DIR_SRC)/*.s)
O_FILES		:= $(DIR_BUILD)/main.o
# O_FILES		:= $(patsubst %.s, $(DIR_BUILD)/%.o, $(notdir $(AS_FILES)))
# O_FILES		:= $(patsubst %.s, $(DIR_BUILD)/%.o, $(notdir $(AS_FILES)))

ifdef DEBUG
	DEBUGFLGS := -g
else
	DEBUGFLGS :=
endif

LDFLAGS := -lSystem -syslibroot `xcrun -sdk macosx --show-sdk-path` -e _start -arch arm64  

build:	$(DIR_BUILD)/main

run: build
	$(DIR_BUILD)/main

$(DIR_BUILD)/%.o : $(DIR_SRC)/%.s $(AS_FILES)
	as $(DEBUGFLGS) -I $(DIR_SRC) $< -o $@

$(DIR_BUILD)/main: $(O_FILES)
# @echo $^
	ld -o $@ $^ $(LDFLAGS)

clean:
	rm -rf $(DIR_BUILD)/*

