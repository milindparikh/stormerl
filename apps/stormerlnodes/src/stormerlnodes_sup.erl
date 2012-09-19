-module(stormerlnodes_sup).
-behaviour(supervisor).

%API
-export([start_link/0]).
% supervisor 
-export([init/1]).


-define (SERVER , ?MODULE).


start_link() -> 
   supervisor:start_link({local, ?SERVER}, ?MODULE, []).


init([]) -> 
   Server = {stormerlnodes_server, {stormerlnodes_server, start_link, []},
      permanent, 2000, worker, [stormerlnodes_server]},
   Children = [Server],
   RestartStrategy = {one_for_one, 0, 1},
   {ok, {RestartStrategy, Children}}.

