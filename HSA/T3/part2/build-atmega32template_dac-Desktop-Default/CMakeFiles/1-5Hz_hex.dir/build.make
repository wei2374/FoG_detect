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
CMAKE_SOURCE_DIR = /home/wei/Desktop/T3/part2/atmega32template_dac

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default

# Utility rule file for 1-5Hz_hex.

# Include the progress variables for this target.
include CMakeFiles/1-5Hz_hex.dir/progress.make

CMakeFiles/1-5Hz_hex: 1-5Hz.hex


1-5Hz.hex: 1-5Hz
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Create hex file of target 1-5Hz."
	avr-objcopy -O ihex -R .eeprom -R .fuse -R .lock -R .mmcu /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default/1-5Hz 1-5Hz.hex

1-5Hz_hex: CMakeFiles/1-5Hz_hex
1-5Hz_hex: 1-5Hz.hex
1-5Hz_hex: CMakeFiles/1-5Hz_hex.dir/build.make

.PHONY : 1-5Hz_hex

# Rule to build all files generated by this target.
CMakeFiles/1-5Hz_hex.dir/build: 1-5Hz_hex

.PHONY : CMakeFiles/1-5Hz_hex.dir/build

CMakeFiles/1-5Hz_hex.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/1-5Hz_hex.dir/cmake_clean.cmake
.PHONY : CMakeFiles/1-5Hz_hex.dir/clean

CMakeFiles/1-5Hz_hex.dir/depend:
	cd /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/wei/Desktop/T3/part2/atmega32template_dac /home/wei/Desktop/T3/part2/atmega32template_dac /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default/CMakeFiles/1-5Hz_hex.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/1-5Hz_hex.dir/depend

