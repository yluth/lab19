
type id = int
type action =
  | Balance           (* balance inquiry *)
  | Withdraw of int   (* withdraw an amount *)
  | Deposit of int    (* deposit an amount *)
  | Next              (* finish this customer and move on to the next one *)
  | Finished          (* shut down the ATM and exit entirely *)


type account_spec = {name : string; id : id; balance : int}

let database : account_spec list ref = ref []

let initialize (init : account_spec list) : unit =
  database := init 

let present_message (message: string) : unit =
  print_endline message

let acquire_id : unit -> id =
  print_string "Enter customer id: " ;
  read_int

let acquire_amount: unit -> int = 
  print_string "Enter amount: " ;
  read_int

let rec acquire_act () : action = 
  print_string "Enter action: (B) Balance (-) Withdraw (+) Deposit (=) Done (X) Exit: " ;
  let choice = read_line () in
  match choice with
  | "B" -> Balance
  | "=" -> Next
  | "X" -> Finished
  | "+" -> let amt = acquire_amount () in Deposit(amt)
  | "-" -> let amt = acquire_amount () in Withdraw(amt)
  | _ -> acquire_act ()

let get_balance (user_id : id) : int =
  let filtered = List.filter (fun act -> act.id = user_id) !database in
  match filtered with
  | [] -> raise Not_found
  | hd :: _ -> hd.balance

let get_name (user_id : id) : string =
  let filtered = List.filter (fun act -> act.id = user_id) !database in
  match filtered with
  | [] -> raise Not_found
  | hd :: _ -> hd.name

let update_balance (user_id : id) (new_balance: int) : unit =
  database := List.map 
              (fun act -> if act.id = user_id then {name = act.name ; id = act.id ; balance = new_balance} else act ) 
              !database

let deliver_cash (amt: int) : unit =
  present_message ("Here's your cash: " ^ (string_of_int amt) )


