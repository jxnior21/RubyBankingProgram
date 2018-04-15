class BankingProgram

  private

  @@banking_account = {
  Angel_Lopez: "0621",
  Carlos_Ortiz: "1452"
  }
  @@account_balance = {
  Angel_Lopez: "2000",
  Carlos_Ortiz: "125301"
  }

  @@balance = nil

  @@name = nil

  @@current_user = nil

  @@pin_num = nil

  @@choice = nil

  def self.pin_error
    puts "\nIncorrect PIN number\n\n"
    menu
  end

  public

  def self.main
    puts "\nWelcome\n\n"
    t = Time.new
    puts t.strftime("Today is %m/%d/%Y")
    menu
  end

  def self.menu
    puts "\nWhat will you like to do?\n
    Type -Log- to log into your bank account\n
    Type -New- to make a new bank account\n
    Type -Exit- to exit the program\n\n\n"
    print ">>"
    @@choice = gets.chomp
    @@choice.capitalize!
    choice
  end

  def self.choice
    case @@choice
    when "Log" then log
    when "New" then new
    when "Exit" then exit
    else
      puts "\n>>Invalid command, please try again!\n\n"
      menu
    end
  end

  def self.log
    print "\n>>Please type in your PIN number(4-digit): "
    pin = gets.chomp
    if pin.length > 4
      puts "\n\n>>PIN number is more than 4 digits\n\n"
      menu
    elsif pin.length < 4
      puts "\n\n>>PIN number is less than 4 digits\n\n"
      menu
    else
      @@pin_num = pin
      if @@banking_account.has_value?(@@pin_num)
        @@current_user = @@pin_num
        @@name = @@banking_account.key(@@pin_num)
        @@name = @@name.to_s
        if @@name.include? "_"
          @@name.gsub!(/_/," ")
          puts "\n>>Hello, #{@@name}\n\n"
          balance
        else
          puts "\n>>Hello, #{@@name}\n\n"
          balance
          end
      else
        pin_error
      end
    end
  end

  def self.new
    print "\n\n>>Please type in your full name(Ex: John Doe): "
    name = gets.chomp
    print "\n>>Please type in your new pin number(4-digit): "
    pin_num = gets.chomp
    if pin_num.length > 4
      puts "\n\n>>PIN number is more than 4 digits\n\n"
      menu
    elsif pin_num.length < 4
      puts "\n\n>>PIN number is less than 4 digits\n\n"
      menu
    else
      print "\n>>Please comfirm your new pin number(4-digit): "
      pin_num2 = gets.chomp
      if pin_num != pin_num2
        print "\n\n>>Incorrect pin\n\n"
        menu
      else
        @@name = name
        @@pin_num = pin_num
        @@name.gsub!(/ /, "_")
        @@pin_num.to_s
        @@banking_account[@@name.to_sym] = @@pin_num
        print "\n>>What is your balance?(Ex: 12345)\n\n$"
        @@balance = gets.chomp
        @@account_balance[@@name.to_sym] = @@balance
        puts "\n>>Bank account created\n\n"
        menu
      end
    end
  end

  def self.exit
    puts "\n===EXIT===\n\n"
  end

  def self.balance
    @@name.gsub!(/ /,"_")
    @@balance = @@account_balance.fetch(@@name.to_sym)
    puts ">>Your balance is: $#{@@balance}\n\n"
    submenu
  end

  def self.submenu
    puts "\n>>What else would you like to do\n
    Type -Deposit- to deposit money into your account\n
    Type -Withdraw- to withdraw money from your account\n
    Type -Cancel- to stop your bank account\n
    Type -Logout- to logout of your account\n\n"
    @@choice1 = gets.chomp
    @@choice1.capitalize!
    choice1
  end

  def self.choice1
    case @@choice1
    when "Deposit" then deposit
    when "Withdraw" then withdraw
    when "Cancel" then cancel
    when "Logout" then logout
    else
      puts "\n>>Invalid command, please try again!\n\n"
      submenu
    end
  end

  def self.deposit
    print "\n>>How much will you like to deposit?\n\n$"
    deposit = gets.chomp
    deposit = deposit.to_i
    @@balance = @@balance.to_i
    @@balance += deposit
    @@balance = @@balance.to_s
    puts "\n>>Your new balance is $#{@@balance}\n\n"
    @@account_balance[@@name.to_sym] = @@balance
    submenu
  end

  def self.withdraw
    print "\n>>How much will you like to withdraw?\n\n$"
    withdraw = gets.chomp
    withdraw = withdraw.to_i
    @@balance = @@balance.to_i
    if withdraw > @@balance
      @@balance = @@balance.to_s
      puts "\nThat amount is to high, the most you can withdraw is $#{@@balance}\n\n"
      submenu
    else
      @@balance -= withdraw
      @@balance = @@balance.to_s
      print "\n>>Your new balance is $#{@@balance}\n\n"
      @@account_balance[@@name.to_sym] = @@balance
      submenu
    end
  end

  def self.cancel
    print "\n>>Are you sure you want to cancel your account?(Y/N)\n\n"
    cancel = gets.chomp
    cancel = cancel.capitalize
    if cancel == "Y"
      @@name.gsub!(/ /,"_")
      @@name = @@name.to_sym
      @@banking_account.delete(@@name)
      @@account_balance.delete(@@name)
      print "\nAccount deleted\n\n"
      menu
    else
    submenu
    end
  end

  def self.logout
    @@current_user = nil
    main
  end


end

BankingProgram.main
