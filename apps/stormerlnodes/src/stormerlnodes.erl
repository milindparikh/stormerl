-module(stormerlnodes).
-export([
	start_node/0, 
	stop_node/0 ]).

start_node () -> 
    application:start(stormerlnodes).

stop_node () -> 
    stormerlnodes_server:stop_link().
