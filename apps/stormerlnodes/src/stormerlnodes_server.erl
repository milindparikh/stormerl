-module(stormerlnodes_server).
-include_lib("../../stormerlutils/include/stormerlutils.hrl").

-behaviour(gen_server).

%% API
  -export([
    start_link/0,
%    register_node/0,
%    deregister_node/0,
    lsnode/0,
    stop_link/0
  ]).
%% gen_server callbacks
  -export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

-define(SERVER, ?MODULE).
-record(state, {conn}).


start_link() -> 
   gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).


lsnode() -> 
   gen_server:call(?SERVER, lsnode).

stop_link() -> 
   gen_server:cast(?SERVER, stop_link).



init([]) -> 

  {ok, Conn} = ezk:start_connection(),

  case ezk:exists(Conn, ?STORMERL_NODEPATH++"/"++ atom_to_list(node())) of 
         {ok, _} -> ok;
         {error, no_dir} -> 
              ezk:create(Conn, 
	      		 ?STORMERL_NODEPATH++"/"++ atom_to_list(node()),
                         list_to_binary("R"), 
                         e)
  end,

  {ok, #state{conn = Conn}, 0}.


handle_call(lsnode, _From, State) -> 
   {reply, {ok, "ABC"}, State}.

handle_cast(stop_link, State) -> 
     {stop, normal, State}.


handle_info({?STORMERL_NODEWATCH, Event}, State) -> 
   ezk:exists(State#state.conn, ?STORMERL_NODEPATH, self(), ?STORMERL_NODEWATCH),
   io:format("Figuing"),
   {noreply, State}	;
    
handle_info(timeout, State) -> 
   ezk:exists(State#state.conn, ?STORMERL_NODEPATH, self(), ?STORMERL_NODEWATCH),
   {noreply, State}.

terminate(Reason, State) -> 
    ezk:end_connection(State#state.conn, Reason),
    ok.

code_change(_OldVsn, State, _Extra) -> 
   {ok, State}.


