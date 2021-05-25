GOAL="start"
MAIN_FILE=nani_search.pl
EXEC_FILE=nani_search.o
BUILD_DIR=build
SRC_DIR=src
IMAGE=swipl-rest-example

dev:
	swipl -s $(SRC_DIR)/$(MAIN_FILE)

$(BUILD_DIR): 
	mkdir $(BUILD_DIR)

compile: | $(BUILD_DIR)
	swipl --goal=$(GOAL) --stand_alone=true -o $(BUILD_DIR)/$(EXEC_FILE) -c $(SRC_DIR)/$(MAIN_FILE)

run: compile
	$(BUILD_DIR)/$(EXEC_FILE)