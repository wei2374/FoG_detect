# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/wei/Desktop/T3/Atmega32Template

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default

# Utility rule file for blink2_hex.

# Include the progress variables for this target.
include CMakeFiles/blink2_hex.dir/progress.make

CMakeFiles/blink2_hex: blink2.hex


blink2.hex: blink2
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Create hex file of target blink2."
	avr-objcopy -O ihex -R .eeprom -R .fuse -R .lock -R .mmcu /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default/blink2 blink2.hex

blink2_hex: CMakeFiles/blink2_hex
blink2_hex: blink2.hex
blink2_hex: CMakeFiles/blink2_hex.dir/build.make

.PHONY : blink2_hex

# Rule to build all files generated by this target.
CMakeFiles/blink2_hex.dir/build: blink2_hex

.PHONY : CMakeFiles/blink2_hex.dir/build

CMakeFiles/blink2_hex.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/blink2_hex.dir/cmake_clean.cmake
.PHONY : CMakeFiles/blink2_hex.dir/clean

CMakeFiles/blink2_hex.dir/depend:
	cd /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/wei/Desktop/T3/Atmega32Template /home/wei/Desktop/T3/Atmega32Template /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default/CMakeFiles/blink2_hex.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/blink2_hex.dir/depend

