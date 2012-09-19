-module(stormerlutils).
-include_lib("../include/stormerlutils.hrl").
-export([initmetadata/0, lsnodes/0, deploytopology/3]).


initmetadata() -> 
    {ok, Conn} = ezk:start_connection(),
    ezk:create(Conn, ?STORMERL_ROOTPATH, list_to_binary("main root for stormerl")),
    ezk:create(Conn, ?STORMERL_NODEPATH, list_to_binary("path for live nodes")),
    ezk:create(Conn, ?STORMERL_TOPOLOGYPATH, list_to_binary("path for topologies ")),
    ezk:create(Conn, ?STORMERL_DEFTOPOLOGYPATH, list_to_binary("path for defined topologies ")),
    ezk:create(Conn, ?STORMERL_ACTTOPOLOGYPATH, list_to_binary("path for active topologies ")),
    ezk:end_connection(Conn, noreason).

deploytopology(TopologyName, TopologyDescription,  TopologyDefinition) ->
    deploytopology(TopologyName, TopologyDescription, "1_0_0", TopologyDefinition).

deploytopology(_TopologyName, _TopologyDescription, _TopologyVsn, _TopologyDefinition) -> ok.
    
lsnodes() -> 
    {ok, Conn} = ezk:start_connection(),
    {ok, ListNodes } = ezk:ls(Conn, ?STORMERL_NODEPATH),
    ezk:end_connection(Conn, noreason), 
    ListNodes.


