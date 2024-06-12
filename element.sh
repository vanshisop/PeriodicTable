PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
echo -e "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
  FIND_ELEMENT_BY_ID=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
    if [[ $FIND_ELEMENT_BY_ID ]]
    then
      FIND_SYMBOL_BY_ID=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
      FIND_TYPE_BY_ID=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number = $1")
      FIND_MASS_BY_ID=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
      FIND_BOILING_POINT_BY_ID=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
      FIND_MELTING_POINT_BY_ID=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
      echo "The element with atomic number $1 is $FIND_ELEMENT_BY_ID ($FIND_SYMBOL_BY_ID). It's a $FIND_TYPE_BY_ID, with a mass of $FIND_MASS_BY_ID amu. $FIND_ELEMENT_BY_ID has a melting point of $FIND_MELTING_POINT_BY_ID celsius and a boiling point of $FIND_BOILING_POINT_BY_ID celsius."
    else
    echo -e "I could not find that element in the database."
    fi
  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
  FIND_ELEMENT_BY_SYMBOL=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
  if [[ $FIND_ELEMENT_BY_SYMBOL ]]
    then
      FIND_ID_BY_SYMBOL=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
      FIND_TYPE_BY_ID=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number = $FIND_ID_BY_SYMBOL")
      FIND_MASS_BY_ID=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $FIND_ID_BY_SYMBOL")
      FIND_BOILING_POINT_BY_ID=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $FIND_ID_BY_SYMBOL")
      FIND_MELTING_POINT_BY_ID=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $FIND_ID_BY_SYMBOL")
      echo "The element with atomic number $FIND_ID_BY_SYMBOL is $FIND_ELEMENT_BY_SYMBOL ($1). It's a $FIND_TYPE_BY_ID, with a mass of $FIND_MASS_BY_ID amu. $FIND_ELEMENT_BY_SYMBOL has a melting point of $FIND_MELTING_POINT_BY_ID celsius and a boiling point of $FIND_BOILING_POINT_BY_ID celsius."
    else
    echo -e "I could not find that element in the database."
   fi

  else
  FIND_ID_BY_NAME=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
  if [[ $FIND_ID_BY_NAME ]]
    then
      FIND_SYMBOL_BY_ID=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $FIND_ID_BY_NAME")
      FIND_TYPE_BY_ID=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number = $FIND_ID_BY_NAME")
      FIND_MASS_BY_ID=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $FIND_ID_BY_NAME")
      FIND_BOILING_POINT_BY_ID=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $FIND_ID_BY_NAME")
      FIND_MELTING_POINT_BY_ID=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $FIND_ID_BY_NAME")
      echo "The element with atomic number $FIND_ID_BY_NAME is $1 ($FIND_SYMBOL_BY_ID). It's a $FIND_TYPE_BY_ID, with a mass of $FIND_MASS_BY_ID amu. $1 has a melting point of $FIND_MELTING_POINT_BY_ID celsius and a boiling point of $FIND_BOILING_POINT_BY_ID celsius."
    else
    echo -e "I could not find that element in the database."
    fi
  fi
fi
