major_version: "local"
minor_version: ""
default_target_cpu: "same_as_host"

toolchain {
  abi_version: "armeabi"
  abi_libc_version: "armeabi"
  builtin_sysroot: ""
  compiler: "compiler"
  host_system_name: "armeabi"
  needsPic: true
  supports_gold_linker: false
  supports_incremental_linker: false
  supports_fission: false
  supports_interface_shared_objects: false
  supports_normalizing_ar: false
  supports_start_end_lib: false
  target_libc: "armeabi"
  target_cpu: "armeabi"
  target_system_name: "armeabi"
  toolchain_identifier: "yocto-linux-gnueabihf"

  tool_path { name: "ar" path:        "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-ar" }
  tool_path { name: "compat-ld" path: "/bin/false" }
  tool_path { name: "cpp" path:       "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-cpp" }
  tool_path { name: "dwp" path:       "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-dwp" }
  tool_path { name: "gcc" path:       "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-gcc" }
  tool_path { name: "gcov" path:      "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-gcov" }
  tool_path { name: "ld" path:        "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-ld" }

  tool_path { name: "nm" path:        "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-nm" }
  tool_path { name: "objcopy" path:   "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-objcopy" }
  tool_path { name: "objdump" path:   "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-objdump" }
  tool_path { name: "strip" path:     "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/bin/%%CT_NAME%%/%%CT_NAME%%-strip" }


  cxx_builtin_include_directory: "%%YOCTO_COMPILER_PATH%%"

  compiler_flag: "--sysroot=%%YOCTO_COMPILER_PATH%%/recipe-sysroot"

  # The path below must match the one used in
  # tensorflow/tools/ci_build/pi/build_raspberry_pi.sh.
  cxx_builtin_include_directory: "/tmp/openblas_install/include/"
  cxx_flag: "-std=c++11"
  # The cxx_builtin_include_directory directives don't seem to be adding these, so
  # explicitly set them as flags. There's a query to the Bazel team outstanding about
  # why this is necessary.
  linker_flag: "-lstdc++"

  unfiltered_cxx_flag: "-Wno-builtin-macro-redefined"
  unfiltered_cxx_flag: "-D__DATE__=\"redacted\""
  unfiltered_cxx_flag: "-D__TIMESTAMP__=\"redacted\""
  unfiltered_cxx_flag: "-D__TIME__=\"redacted\""

  unfiltered_cxx_flag: "-no-canonical-prefixes"
  unfiltered_cxx_flag: "-fno-canonical-system-headers"

  # Include target pyconfig.h
  compiler_flag: "-D_PYTHON_INCLUDE_TARGET"

  compiler_flag: "-U_FORTIFY_SOURCE"
  compiler_flag: "-D_FORTIFY_SOURCE=1"
  compiler_flag: "-fstack-protector"
  compiler_flag: "-DRASPBERRY_PI"  # To differentiate from mobile builds.
  linker_flag: "-Wl,-z,relro,-z,now"

  linker_flag: "-no-canonical-prefixes"
  linker_flag: "-pass-exit-codes"

  linker_flag: "-Wl,--build-id=md5"

  compilation_mode_flags {
    mode: DBG
    # Enable debug symbols.
    compiler_flag: "-g"
  }
  compilation_mode_flags {
    mode: OPT

    # No debug symbols.
    # Maybe we should enable https://gcc.gnu.org/wiki/DebugFission for opt or
    # even generally? However, that can't happen here, as it requires special
    # handling in Bazel.
    compiler_flag: "-g0"

    # Conservative choice for -O
    # -O3 can increase binary size and even slow down the resulting binaries.
    # Profile first and / or use FDO if you need better performance than this.
    compiler_flag: "-O2"

    # Disable assertions
    compiler_flag: "-DNDEBUG"

    # Removal of unused code and data at link time (can this increase binary size in some cases?).
    compiler_flag: "-ffunction-sections"
    compiler_flag: "-fdata-sections"
    linker_flag: "-Wl,--gc-sections"
  }
  linking_mode_flags { mode: DYNAMIC }

}

toolchain {
  abi_version: "local"
  abi_libc_version: "local"
  builtin_sysroot: ""
  compiler: "compiler"
  host_system_name: "local"
  needsPic: true
  supports_gold_linker: false
  supports_incremental_linker: false
  supports_fission: false
  supports_interface_shared_objects: false
  supports_normalizing_ar: false
  supports_start_end_lib: false
  target_libc: "local"
  target_cpu: "local"
  target_system_name: "local"
  toolchain_identifier: "local_linux"

  tool_path { name: "ar" path: "/usr/bin/ar" }
  tool_path { name: "compat-ld" path: "/usr/bin/ld" }
  tool_path { name: "cpp" path: "/usr/bin/cpp" }
  tool_path { name: "dwp" path: "/usr/bin/dwp" }
  tool_path { name: "gcc" path: "/usr/bin/gcc" }
  cxx_flag: "-std=c++0x"
  linker_flag: "-lstdc++"
  linker_flag: "-B/usr/bin/"

  # TODO(bazel-team): In theory, the path here ought to exactly match the path
  # used by gcc. That works because bazel currently doesn't track files at
  # absolute locations and has no remote execution, yet. However, this will need
  # to be fixed, maybe with auto-detection?
  cxx_builtin_include_directory: "/usr/lib/gcc/"
  cxx_builtin_include_directory: "/usr/local/include"
  cxx_builtin_include_directory: "/usr/include"
  cxx_builtin_include_directory: "%%YOCTO_COMPILER_PATH%%/recipe-sysroot-native/usr/include"

  tool_path { name: "gcov" path: "/usr/bin/gcov" }

  # C(++) compiles invoke the compiler (as that is the one knowing where
  # to find libraries), but we provide LD so other rules can invoke the linker.
  tool_path { name: "ld" path: "/usr/bin/ld" }

  tool_path { name: "nm" path: "/usr/bin/nm" }
  tool_path { name: "objcopy" path: "/usr/bin/objcopy" }
  objcopy_embed_flag: "-I"
  objcopy_embed_flag: "binary"
  tool_path { name: "objdump" path: "/usr/bin/objdump" }
  tool_path { name: "strip" path: "/usr/bin/strip" }

  # Anticipated future default.
  unfiltered_cxx_flag: "-no-canonical-prefixes"
  unfiltered_cxx_flag: "-fno-canonical-system-headers"

  # Make C++ compilation deterministic. Use linkstamping instead of these
  # compiler symbols.
  unfiltered_cxx_flag: "-Wno-builtin-macro-redefined"
  unfiltered_cxx_flag: "-D__DATE__=\"redacted\""
  unfiltered_cxx_flag: "-D__TIMESTAMP__=\"redacted\""
  unfiltered_cxx_flag: "-D__TIME__=\"redacted\""

  # Security hardening on by default.
  # Conservative choice; -D_FORTIFY_SOURCE=2 may be unsafe in some cases.
  # We need to undef it before redefining it as some distributions now have
  # it enabled by default.
  compiler_flag: "-U_FORTIFY_SOURCE"
  compiler_flag: "-D_FORTIFY_SOURCE=1"
  compiler_flag: "-fstack-protector"
  linker_flag: "-Wl,-z,relro,-z,now"

  # Include native pyconfig.h
  compiler_flag: "-D_PYTHON_INCLUDE_NATIVE"

  # Enable coloring even if there's no attached terminal. Bazel removes the
  # escape sequences if --nocolor is specified. This isn't supported by gcc
  # on Ubuntu 14.04.
  # compiler_flag: "-fcolor-diagnostics"

  # All warnings are enabled. Maybe enable -Werror as well?
  compiler_flag: "-Wall"
  # Enable a few more warnings that aren't part of -Wall.
  compiler_flag: "-Wunused-but-set-parameter"
  # But disable some that are problematic.
  compiler_flag: "-Wno-free-nonheap-object" # has false positives

  # Keep stack frames for debugging, even in opt mode.
  compiler_flag: "-fno-omit-frame-pointer"

  # Anticipated future default.
  linker_flag: "-no-canonical-prefixes"
  # Have gcc return the exit code from ld.
  linker_flag: "-pass-exit-codes"
  # Stamp the binary with a unique identifier.
  linker_flag: "-Wl,--build-id=md5"
  linker_flag: "-Wl,--hash-style=gnu"
  # Gold linker only? Can we enable this by default?
  # linker_flag: "-Wl,--warn-execstack"
  # linker_flag: "-Wl,--detect-odr-violations"

  compilation_mode_flags {
    mode: DBG
    # Enable debug symbols.
    compiler_flag: "-g"
  }
  compilation_mode_flags {
    mode: OPT

    # No debug symbols.
    # Maybe we should enable https://gcc.gnu.org/wiki/DebugFission for opt or
    # even generally? However, that can't happen here, as it requires special
    # handling in Bazel.
    compiler_flag: "-g0"

    # Conservative choice for -O
    # -O3 can increase binary size and even slow down the resulting binaries.
    # Profile first and / or use FDO if you need better performance than this.
    compiler_flag: "-O2"

    # Disable assertions
    compiler_flag: "-DNDEBUG"

    # Removal of unused code and data at link time (can this increase binary size in some cases?).
    compiler_flag: "-ffunction-sections"
    compiler_flag: "-fdata-sections"
    linker_flag: "-Wl,--gc-sections"
  }
  linking_mode_flags { mode: DYNAMIC }
}
