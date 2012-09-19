{application, stormerlnodes, 
          [{description, []}, 
           {vsn, "1.0.1"}, 
           {registered, []}, 
           {applications, [kernel, stdlib, ezk]},
           {mod, {stormerlnodes_app, []}},
           {modules, [stormerlnodes_app, stormerlnodes_sup, stormerlnodes_server, stormerlnodes ]}]}.
