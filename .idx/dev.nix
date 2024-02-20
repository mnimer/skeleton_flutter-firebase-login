{ pkgs, ... }: {
  channel = "stable-23.11"; # "stable-23.11" or "unstable"
  packages = [
    pkgs.flutter
    pkgs.jdk17
    pkgs.flutter
    pkgs.firebase-tools
  ];
  idx.extensions = [];
  idx.previews = {
    enable = true;
    previews = [
        {
            command = ["flutter" "run" "--machine" "-d" "web-server" "--web-hostname" "0.0.0.0" "--web-port" "$PORT"];
            id = "web";
            manager = "flutter";
            cwd = "app";
        }
        {
            command = ["flutter" "run" "--machine" "-d" "android" "-d" "localhost:5555"];
            id = "android";
            manager = "flutter";
            cwd = "app";

        }
        {
            id = "ios";
            manager = "ios";
            cwd = "app";
        }
    ];
  };
}
