type t

val open_link : ?filter:string -> string -> t
val close_link : t -> unit
val get_packet : t -> string
val get_packet_list : t -> string list
val put_packet : t -> string -> unit
val dhcp_filter : unit -> string
