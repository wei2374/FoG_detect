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
CMAKE_SOURCE_DIR = /home/wei/Desktop/T3/part2/TumIcsAvrSimPotentiometerBlinkTemplate

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/wei/Desktop/T3/part2/build-TumIcsAvrSimPotentiometerBlinkTemplate-Desktop-Default

# Include any dependencies generated for this target.
include CMakeFiles/avr_sim_poti_led_template.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/avr_sim_poti_led_template.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/avr_sim_poti_led_template.dir/flags.make

CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o: CMakeFiles/avr_sim_poti_led_template.dir/flags.make
CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o: /home/wei/Desktop/T3/part2/TumIcsAvrSimPotentiometerBlinkTemplate/src/Applications/main_avr_sim_poti_led_template.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/wei/Desktop/T3/part2/build-TumIcsAvrSimPotentiometerBlinkTemplate-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o"
	/usr/bin/g++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o -c /home/wei/Desktop/T3/part2/TumIcsAvrSimPotentiometerBlinkTemplate/src/Applications/main_avr_sim_poti_led_template.cpp

CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.i"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/wei/Desktop/T3/part2/TumIcsAvrSimPotentiometerBlinkTemplate/src/Applications/main_avr_sim_poti_led_template.cpp > CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.i

CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.s"
	/usr/bin/g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/wei/Desktop/T3/part2/TumIcsAvrSimPotentiometerBlinkTemplate/src/Applications/main_avr_sim_poti_led_template.cpp -o CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.s

CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o.requires:

.PHONY : CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o.requires

CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o.provides: CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o.requires
	$(MAKE) -f CMakeFiles/avr_sim_poti_led_template.dir/build.make CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o.provides.build
.PHONY : CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o.provides

CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o.provides.build: CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o


# Object files for target avr_sim_poti_led_template
avr_sim_poti_led_template_OBJECTS = \
"CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o"

# External object files for target avr_sim_poti_led_template
avr_sim_poti_led_template_EXTERNAL_OBJECTS =

avr_sim_poti_led_template: CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o
avr_sim_poti_led_template: CMakeFiles/avr_sim_poti_led_template.dir/build.make
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimLed.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimTools.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimCore.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimInput.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimTools.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimCore.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimUart.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimTools.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimCore.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimPotentiometer.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimTools.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimCore.so
avr_sim_poti_led_template: /usr/lib/tum_ics_tools/libtumicsToolsCommon.so
avr_sim_poti_led_template: /usr/lib/x86_64-linux-gnu/libQtGui.so
avr_sim_poti_led_template: /usr/lib/x86_64-linux-gnu/libQtCore.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimInput.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimUart.so
avr_sim_poti_led_template: /usr/lib/tum_ics_avr_sim/libtumicsAvrSimPotentiometer.so
avr_sim_poti_led_template: /usr/lib/tum_ics_tools/libtumicsToolsCommon.so
avr_sim_poti_led_template: /usr/lib/x86_64-linux-gnu/libQtGui.so
avr_sim_poti_led_template: /usr/lib/x86_64-linux-gnu/libQtCore.so
avr_sim_poti_led_template: CMakeFiles/avr_sim_poti_led_template.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/wei/Desktop/T3/part2/build-TumIcsAvrSimPotentiometerBlinkTemplate-Desktop-Default/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable avr_sim_poti_led_template"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/avr_sim_poti_led_template.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/avr_sim_poti_led_template.dir/build: avr_sim_poti_led_template

.PHONY : CMakeFiles/avr_sim_poti_led_template.dir/build

CMakeFiles/avr_sim_poti_led_template.dir/requires: CMakeFiles/avr_sim_poti_led_template.dir/src/Applications/main_avr_sim_poti_led_template.cpp.o.requires

.PHONY : CMakeFiles/avr_sim_poti_led_template.dir/requires

CMakeFiles/avr_sim_poti_led_template.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/avr_sim_poti_led_template.dir/cmake_clean.cmake
.PHONY : CMakeFiles/avr_sim_poti_led_template.dir/clean

CMakeFiles/avr_sim_poti_led_template.dir/depend:
	cd /home/wei/Desktop/T3/part2/build-TumIcsAvrSimPotentiometerBlinkTemplate-Desktop-Default && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/wei/Desktop/T3/part2/TumIcsAvrSimPotentiometerBlinkTemplate /home/wei/Desktop/T3/part2/TumIcsAvrSimPotentiometerBlinkTemplate /home/wei/Desktop/T3/part2/build-TumIcsAvrSimPotentiometerBlinkTemplate-Desktop-Default /home/wei/Desktop/T3/part2/build-TumIcsAvrSimPotentiometerBlinkTemplate-Desktop-Default /home/wei/Desktop/T3/part2/build-TumIcsAvrSimPotentiometerBlinkTemplate-Desktop-Default/CMakeFiles/avr_sim_poti_led_template.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/avr_sim_poti_led_template.dir/depend

