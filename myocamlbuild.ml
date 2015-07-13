(*
 * Copyright (c) 2015 Christiano F. Haesbaert <haesbaert@haesbaert.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *)

open Ocamlbuild_plugin;;
dispatch begin function
  | After_rules ->
    pflag ["ocaml";"compile";] "ppopt" (fun s -> S [A"-ppopt"; A s]);
    pflag ["ocaml";"ocamldep";] "ppopt" (fun s -> S [A"-ppopt"; A s]);
    pdep ["link"] "linkdep" (fun param -> [param]);
    (* Linking generated stubs *)
    dep ["ocaml"; "link"; "byte"; "library"; "use_rawlink_stubs"]
      ["lib/dllrawlink_stubs"-.-(!Options.ext_dll)];
    flag ["ocaml"; "link"; "byte"; "library"; "use_rawlink_stubs"] &
    S[A"-dllib"; A"-lrawlink_stubs"];

    dep ["ocaml"; "link"; "native"; "library"; "use_rawlink_stubs"]
      ["lib/librawlink_stubs"-.-(!Options.ext_lib)];
    flag ["ocaml"; "link"; "native"; "library"; "use_rawlink_stubs"] &
      S[A"-cclib"; A"-lrawlink_stubs"];
  | _ -> ()
end;;
