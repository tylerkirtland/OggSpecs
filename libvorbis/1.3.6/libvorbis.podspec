Pod::Spec.new do |s|
  name = "vorbis"
  libname = "lib" + name
  ver = "1.3.6"
  libver = libname + "-" + ver

  s.name         = "libvorbis"
  s.version      = ver
  s.summary      = "Low-level Vorbis audio codec library"

  s.description  = <<-DESC
                   Xiph's C-based Vorbis audio codec library, packaged for iOS.
                   Needed for decoding or encoding of audio in Ogg and WebM media.
                   DESC

  s.homepage     = "https://xiph.org/" + name + "/"

  s.license      = { :type => "BSD", :file => "COPYING" }

  s.author             = { "Tyler Kirtland" => "tdkirtland@gmail.com" }
  s.social_media_url   = "https://planet.xiph.org/"

  s.ios.deployment_target = "10.0"
  s.osx.deployment_target = "10.12"

  s.source       = { :git => "git@github.com:xiph/vorbis.git" }
  s.prepare_command = <<-'CMD'
                      echo 'framework module vorbis {' > vorbis.modulemap
                      echo '  module vorbisfile {' >> vorbis.modulemap
                      echo '    header "vorbisfile.h"' >> vorbis.modulemap
                      echo '    header "codec.h"' >> vorbis.modulemap
                      echo '    export *' >> vorbis.modulemap
                      echo '  }' >> vorbis.modulemap
                      echo '  module vorbisenc {' >> vorbis.modulemap
                      echo '    header "vorbisenc.h"' >> vorbis.modulemap
                      echo '    header "codec.h"' >> vorbis.modulemap
                      echo '    export *' >> vorbis.modulemap
                      echo '  }' >> vorbis.modulemap
                      echo '}' >> vorbis.modulemap
                      CMD

  s.compiler_flags = "-O3",
                     "-iquote \"$PODS_ROOT/libvorbis/lib\"", # hack for use of #include "foo/bar" in subdirs relative to base dir
                     "-Wno-conversion",
                     "-Wno-unused-variable",
                     "-Wno-unused-function",
                     "-Wno-documentation-deprecated-sync",
                     "-Wno-shorten-64-to-32"

  s.source_files = "lib/**/*.{c,h}",
                   "include/**/*.h"
  s.exclude_files = "lib/psytune.c", # dead code that doesn't compile
                    "lib/tone.c",    # test util
                    "lib/barkmel.c"  # test util
  s.public_header_files = "include/**/*.h"
  s.header_dir = name
  s.module_name = name
  s.module_map = name + ".modulemap"

  s.dependency 'libogg'
end
