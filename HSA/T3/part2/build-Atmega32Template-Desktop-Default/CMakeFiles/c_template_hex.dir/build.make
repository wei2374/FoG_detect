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
CMAKE_SOURCE_DIR = /home/wei/Desktop/T3/part2/Atmega32Template

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/wei/Desktop/T3/part2/build-Atmega32Template-Desktop-Default

# Utility rule file for c_template_hex.

# Include the progress variables for this target.
include CMakeFiles/c_template_hex.dir/progress.make

CMakeFiles/c_template_hex: c_template.hex


c_template.hex: c_template
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/wei/Desktop/T3/part2/build-Atmega32Template-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Create hex file of target c_template."
	avr-objcopy -O ihex -R .eeprom -R .fuse -R .lock -R .mmcu /home/wei/Desktop/T3/part2/build-Atmega32Template-Desktop-Default/c_template c_template.hex

c_template_hex: CMakeFiles/c_template_hex
c_template_hex: c_template.hex
c_template_hex: CMakeFiles/c_template_hex.dir/build.make

.PHONY : c_template_hex

# Rule to build all files generated by this target.
CMakeFiles/c_template_hex.dir/build: c_template_hex

.PHONY : CMakeFiles/c_template_hex.dir/build

CMakeFiles/c_template_hex.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/c_template_hex.dir/cmake_clean.cmake
.PHONY : CMakeFiles/c_template_hex.dir/clean

CMakeFiles/c_template_hex.dir/depend:
	cd /home/wei/Desktop/T3/part2/build-Atmega32Template-Desktop-Default && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/wei/Desktop/T3/part2/Atmega32Template /home/wei/Desktop/T3/part2/Atmega32Template /home/wei/Desktop/T3/part2/build-Atmega32Template-Desktop-Default /home/wei/Desktop/T3/part2/build-Atmega32Template-Desktop-Default /home/wei/Desktop/T3/part2/build-Atmega32Template-Desktop-Default/CMakeFiles/c_template_hex.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/c_template_hex.dir/depend
