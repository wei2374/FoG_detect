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

# Include any dependencies generated for this target.
include CMakeFiles/100Hz.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/100Hz.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/100Hz.dir/flags.make

CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj: CMakeFiles/100Hz.dir/flags.make
CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj: /home/wei/Desktop/T3/part2/atmega32template_dac/src/Applications/main_100Hz.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj   -c /home/wei/Desktop/T3/part2/atmega32template_dac/src/Applications/main_100Hz.c

CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.i"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/wei/Desktop/T3/part2/atmega32template_dac/src/Applications/main_100Hz.c > CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.i

CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.s"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/wei/Desktop/T3/part2/atmega32template_dac/src/Applications/main_100Hz.c -o CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.s

CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj.requires:

.PHONY : CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj.requires

CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj.provides: CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj.requires
	$(MAKE) -f CMakeFiles/100Hz.dir/build.make CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj.provides.build
.PHONY : CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj.provides

CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj.provides.build: CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj


CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj: CMakeFiles/100Hz.dir/flags.make
CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj: /home/wei/Desktop/T3/part2/atmega32template_dac/src/Applications/sim_100Hz.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj   -c /home/wei/Desktop/T3/part2/atmega32template_dac/src/Applications/sim_100Hz.c

CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.i"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/wei/Desktop/T3/part2/atmega32template_dac/src/Applications/sim_100Hz.c > CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.i

CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.s"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/wei/Desktop/T3/part2/atmega32template_dac/src/Applications/sim_100Hz.c -o CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.s

CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj.requires:

.PHONY : CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj.requires

CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj.provides: CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj.requires
	$(MAKE) -f CMakeFiles/100Hz.dir/build.make CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj.provides.build
.PHONY : CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj.provides

CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj.provides.build: CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj


# Object files for target 100Hz
100Hz_OBJECTS = \
"CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj" \
"CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj"

# External object files for target 100Hz
100Hz_EXTERNAL_OBJECTS =

100Hz: CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj
100Hz: CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj
100Hz: CMakeFiles/100Hz.dir/build.make
100Hz: /opt/avr/lib/atmega32/libm32_core.a
100Hz: /opt/avr/lib/libavr_core.a
100Hz: CMakeFiles/100Hz.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable 100Hz"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/100Hz.dir/link.txt --verbose=$(VERBOSE)
	/usr/bin/cmake -E copy /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default/100Hz /home/wei/Desktop/T3/part2/atmega32template_dac/100Hz.elf

# Rule to build all files generated by this target.
CMakeFiles/100Hz.dir/build: 100Hz

.PHONY : CMakeFiles/100Hz.dir/build

CMakeFiles/100Hz.dir/requires: CMakeFiles/100Hz.dir/src/Applications/main_100Hz.c.obj.requires
CMakeFiles/100Hz.dir/requires: CMakeFiles/100Hz.dir/src/Applications/sim_100Hz.c.obj.requires

.PHONY : CMakeFiles/100Hz.dir/requires

CMakeFiles/100Hz.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/100Hz.dir/cmake_clean.cmake
.PHONY : CMakeFiles/100Hz.dir/clean

CMakeFiles/100Hz.dir/depend:
	cd /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/wei/Desktop/T3/part2/atmega32template_dac /home/wei/Desktop/T3/part2/atmega32template_dac /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default /home/wei/Desktop/T3/part2/build-atmega32template_dac-Desktop-Default/CMakeFiles/100Hz.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/100Hz.dir/depend
