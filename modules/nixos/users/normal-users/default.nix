{ options, config, pkgs, lib, ... }:
with lib;
let
  cfg = config.lnixosconf.users.normalUsers;
in
{
  options = {
    lnixosconf.users.normalUsers = with types;
      mkOption {
        type = with types; listOf (submodule {
          options = {
            name = with types; mkOption {
              type = str;
              description = "The name to use for the user account.";
            };
            fullName = with types; mkOption {
              type = str;
              description = "The full name of the user.";
            };
            email = with types; mkOption {
              type = str;
              description = "The email of the user.";
            };
            initialPassword = with types; mkOption {
              type = str;
              description = "The initial password to use when the user is first created.";
            };
            extraGroups = with types; mkOption {
              type = (listOf str);
              description = "Groups for the user to be assigned.";
            };
            extraOptions = with types; mkOption {
              type = attrs;
              description = "Extra options passed to `users.users.<name>`.";
            };
          };
        });
      };
  };

  config = {
    users.users = builtins.listToAttrs
      (map
        (normalUser:
          {
            name = normalUser.name;
            value = {
              isNormalUser = true;
              inherit (normalUser) name initialPassword;
              home = "/home/${normalUser.name}";
              group = "users";
              shell = pkgs.bash;
              extraGroups = [ ] ++ normalUser.extraGroups;
            } // normalUser.extraOptions;
          }
        )
        cfg);
  };
}
