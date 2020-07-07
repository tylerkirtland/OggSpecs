Pod::Spec.new do |s|
  name = "ogg"
  libname = "lib" + name
  ver = "1.3.4"

  s.name         = "libogg"
  s.version      = ver
  s.summary      = "Low-level media demuxer/muxer library"

  s.ios.deployment_target = "10.0"
  s.osx.deployment_target = "10.12"

  s.description  = <<-DESC
                   Xiph's C-based Ogg media stream demuxer/muxer library, packaged for iOS.
                   Needed for decoding or encoding of Ogg Theora video and Vorbis audio.
                   DESC

  s.homepage     = "https://xiph.org/" + name + "/"

  s.license      = { :type => "BSD", :file => "COPYING" }

  s.author             = { "Tyler Kirtland" => "tdkirtland@gmail.com" }
  s.social_media_url   = "https://planet.xiph.org/"

  s.source = { :git => "git@github.com:xiph/ogg.git" }
  s.prepare_command = <<-'CMD'
                      echo 'framework module ogg {' > ogg.modulemap
                      echo '  umbrella header "ogg.h"' >> ogg.modulemap
                      echo '  module ogg {' >> ogg.modulemap
                      echo '    header "ogg.h"' >> ogg.modulemap
                      echo '    export *' >> ogg.modulemap
                      echo '  }' >> ogg.modulemap
                      echo '}' >> ogg.modulemap
                      CMD

  s.compiler_flags = "-O3"
  s.source_files = "src",
                   "include/**/*.h"
  s.public_header_files = "include/**/*.h"
  s.header_dir = name
  s.module_name = name
  s.module_map = name + ".modulemap"
end
