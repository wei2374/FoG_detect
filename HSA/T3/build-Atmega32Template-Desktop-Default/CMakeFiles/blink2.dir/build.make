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

# Include any dependencies generated for this target.
include CMakeFiles/blink2.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/blink2.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/blink2.dir/flags.make

CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj: CMakeFiles/blink2.dir/flags.make
CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj: /home/wei/Desktop/T3/Atmega32Template/src/Applications/main_blink2.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj   -c /home/wei/Desktop/T3/Atmega32Template/src/Applications/main_blink2.c

CMakeFiles/blink2.dir/src/Applications/main_blink2.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/blink2.dir/src/Applications/main_blink2.c.i"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/wei/Desktop/T3/Atmega32Template/src/Applications/main_blink2.c > CMakeFiles/blink2.dir/src/Applications/main_blink2.c.i

CMakeFiles/blink2.dir/src/Applications/main_blink2.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/blink2.dir/src/Applications/main_blink2.c.s"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/wei/Desktop/T3/Atmega32Template/src/Applications/main_blink2.c -o CMakeFiles/blink2.dir/src/Applications/main_blink2.c.s

CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj.requires:

.PHONY : CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj.requires

CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj.provides: CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj.requires
	$(MAKE) -f CMakeFiles/blink2.dir/build.make CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj.provides.build
.PHONY : CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj.provides

CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj.provides.build: CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj


CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj: CMakeFiles/blink2.dir/flags.make
CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj: /home/wei/Desktop/T3/Atmega32Template/src/Applications/sim_blink2.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj   -c /home/wei/Desktop/T3/Atmega32Template/src/Applications/sim_blink2.c

CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.i"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/wei/Desktop/T3/Atmega32Template/src/Applications/sim_blink2.c > CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.i

CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.s"
	/usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/wei/Desktop/T3/Atmega32Template/src/Applications/sim_blink2.c -o CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.s

CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj.requires:

.PHONY : CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj.requires

CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj.provides: CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj.requires
	$(MAKE) -f CMakeFiles/blink2.dir/build.make CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj.provides.build
.PHONY : CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj.provides

CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj.provides.build: CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj


# Object files for target blink2
blink2_OBJECTS = \
"CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj" \
"CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj"

# External object files for target blink2
blink2_EXTERNAL_OBJECTS =

blink2: CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj
blink2: CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj
blink2: CMakeFiles/blink2.dir/build.make
blink2: /opt/avr/lib/atmega32/libm32_core.a
blink2: /opt/avr/lib/libavr_core.a
blink2: CMakeFiles/blink2.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable blink2"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/blink2.dir/link.txt --verbose=$(VERBOSE)
	/usr/bin/cmake -E copy /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default/blink2 /home/wei/Desktop/T3/Atmega32Template/blink2.elf

# Rule to build all files generated by this target.
CMakeFiles/blink2.dir/build: blink2

.PHONY : CMakeFiles/blink2.dir/build

CMakeFiles/blink2.dir/requires: CMakeFiles/blink2.dir/src/Applications/main_blink2.c.obj.requires
CMakeFiles/blink2.dir/requires: CMakeFiles/blink2.dir/src/Applications/sim_blink2.c.obj.requires

.PHONY : CMakeFiles/blink2.dir/requires

CMakeFiles/blink2.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/blink2.dir/cmake_clean.cmake
.PHONY : CMakeFiles/blink2.dir/clean

CMakeFiles/blink2.dir/depend:
	cd /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/wei/Desktop/T3/Atmega32Template /home/wei/Desktop/T3/Atmega32Template /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default /home/wei/Desktop/T3/build-Atmega32Template-Desktop-Default/CMakeFiles/blink2.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/blink2.dir/depend

