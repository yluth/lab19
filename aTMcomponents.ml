module ATMcomponents =
  struct
    type id = int
    type action =
      | Balance           (* balance inquiry *)
      | Withdraw of int   (* withdraw an amount *)
      | Deposit of int    (* deposit an amount *)
      | Next              (* finish this customer and move on to the next one *)
      | Finished          (* shut down the ATM and exit entirely *)
    
    
    type account_spec = {name : string; id : id; balance : int}

    





  end