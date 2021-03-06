/**************************************************************************
 * DOCUMENT:	Prolog Pokedex
 * AUTHOR:	Brittany Postnikoff
 * CREATED:	2014-11-24
 * UPDATED:	2015-02-03
 * PURPOSE:	An expert system to operate like a Pokedex from
 *		  the Pokemon universe.
 * CHANGES:	1, Uploaded previous work
 * BEGIN SYSTEM WITH welcomeMessage.
 **************************************************************************/


/**************************************************************************
 * WELCOME MESSAGE:
 *   This message explains the rules of the expert system in 
 *     an easy to understand and detailed message.
 *   This message is called in the very beginning to explain
 *     things to the user and start the identification process.
 **************************************************************************/
welcomeMessage :-
  write('\n*******************************************************************\nHello there! Welcome to the world of Pokemon! \nMy name is Post! People call me the Pokemon Prof! \nThis world is inhabited by creatures called Pokemon!\n\nThis Pokedex is designed to help identify Pokemon that you may see. \nTo use this Pokedex enter in the Pokemon\'s type, height, and weight. \nType should be entered in using lowercase, height is in centimeters, \nand weight is in grams! \n\nThis system is case sensitive, and spelling specific.\nEach phrase you enter should end in a \'.\'!\n\nEnter the phrase \'identifyPokemon\' to identify a Pokemon.\nEnter the phrase \'help\' for assistance!\n********************************************************************\n\n').


/*********************************************************************
 * HELP MESSAGE:
 *   This guides users in some of the information necessary to operate
 *     the system effectively.
 *********************************************************************/
help :-
  write('\n\n*****************************************************************\nHELP:\n\s\sPlease find directions and information for the Pokedex system \n\s\sin the documentation below!\n*****************************************************************\nType help: \n\s\sType must be a set of characters terminated in a \'.\'. \n\s\sType is case sensitive and must be in lowercase characters.\n\s\sTypes include: \n\s\s\s\snormal \t\tfire \t\t\twater \n\s\s\s\selectric \t\tgrass \t\t\tice \n\s\s\s\sfighting \t\tpoison \t\t\tground \n\s\s\s\sflying \t\tpsychic \t\tbug \n\s\s\s\srock \t\tghost \t\t\tdragon \n\s\s\s\sdark \t\tsteel \t\t\tfairy \n\nHeight help: \n\s\sHeight is in centimeters. \n\s\sHeight must be an integer. \n\s\sHeight must be a set of numbers terminated in a \'.\'. \n\s\sThe default for height is heightDefault.\n\s\sHeight distinctions:\n\s\s\s\stiny is 1 to 20. \n\s\s\s\ssmall is 21 to 80. \n\s\s\s\saverage is 81 to 200. \n\s\s\s\stall is 201 to 300. \n\s\s\s\sveryTall is 301 to 500. \n\s\s\s\scolossal is 500 and up. \n\s\sIt is assumed that no Pokemon is over 20 metres tall. \n\nWeight help: \n\s\sWeight is in grams. \n\s\sWeight is an integer. \n\s\sWeight must be a set of numbers terminated in a \'.\'. \n\s\sThe default for weight is weightDefault.\n\s\sWeight types: \n\s\s\s\slight is 0 to 50000 grams. \n\s\s\s\saverage is 50001 to 150000 grams. \n\s\s\s\sheavy is 150001 to 10000000 grams.\n').


/**************************************************************************
 * INITIALIZING CALL:
 *   This is what is called every time an individual is looking to 
 *     identify a pokemon.
 **************************************************************************/
identifyPokemon :- 
  endQuery,
  typeGet, 
  nl,
  heightGet, 
  nl,
  weightGet, 
  guess(Pokemon),
  nl,
  write('The Pokemon may be '),
  write(Pokemon),
  write('.').

identifyPokemon(why) :- 
  endQuery,
  typeGet, 
  nl,
  heightGet, 
  nl,
  weightGet, 
  nl,
  guess(Pokemon),
  nl,
  write('The Pokemon may be '),
  write(Pokemon).


/**************************************************************************
 * RESET SYSTEM:
 *   Resets the statements gained from assert statements generated by
 *     values received from the users.
 **************************************************************************/
endQuery	:- resetValues.
resetValues 	:- retract(type(_)), fail.
resetValues 	:- retract(height(_)), fail.
resetValues 	:- retract(weight(_)), fail.
resetValues	:- retract(found(_)), fail.
/* DEFAULT STATEMENT */
resetValues	:- assert(found(no)), fail.
resetValues. 


/**************************************************************************
 * IDENTIFICATION QUESTIONS:
 *   Retrieves identifying information from the user.
 *   Namely type, height, and weight.
 **************************************************************************/
typeGet :- 
  write('Enter the Pokemon\'s type: '), 
  read(Type), 
  assert(type(Type)).

heightGet :- 
  write('Enter a description of the Pokemon\'s height!'), 
  nl, 
  write('tiny, small, average, tall, veryTall, or colossal:  '), 
  read(Height), 
  assert(height(Height)).

weightGet :- 
  write('Enter a description of the Pokemon\'s weight!'),
  nl,
  write('light, average, or heavy:  '), 
  read(Weight),
  assert(weight(Weight)).


/**************************************************************************
 * INFORMATION PROCESSING:
 *   Creates connections between descriptive words and 
 *     hard values.
 **************************************************************************/
heightCM(X) :- between(1,20,X), height(tiny), !.
heightCM(X) :- between(21,80,X), height(small), !.
heightCM(X) :- between(81,200,X), height(average), !.
heightCM(X) :- between(201,300,X), height(tall), !.
heightCM(X) :- between(301,500,X), height(veryTall), !.
heightCM(X) :- between(501,2000,X), height(colossal), !.
/*DEFAULT, ALL INCLUSIVE HEIGHT STATEMENT*/
heightCM(X) :- between(1,2000,X), height(defaultHeight).

weightG(X)  :- between(0,50000,X), weight(light), !.
weightG(X)  :- between(50001,150000,X), weight(average), !.
weightG(X)  :- between(150001,10000000,X), weight(heavy), !.
/*DEFAULT, ALL INCLUSIVE WEIGHT STATEMENT*/
weightG(X)  :- between(0,10000000,X), weight(defaultWeight).


/**************************************************************************
 * GUESS STATEMENTS:
 *   Links the guess statement to the Pokemon information. 
 **************************************************************************/
guess(bulbasaur) 	:- bulbasaur, assert(found(yes)).
guess(ivysaur)		:- ivysaur, assert(found(yes)).
guess(venusaur)		:- venusaur, assert(found(yes)).
guess(charmander) 	:- charmander, assert(found(yes)).
guess(charmeleon)	:- charmeleon, assert(found(yes)).
guess(charizard)	:- charizard, assert(found(yes)).
guess(squirtle) 	:- squirtle, assert(found(yes)).
guess(wartortle)	:- wartortle, assert(found(yes)).
guess(blastoise)	:- blastoise, assert(found(yes)).
guess(caterpie)		:- caterpie, assert(found(yes)).
guess(metapod)		:- metapod, assert(found(yes)).
guess(butterfree)	:- butterfree, assert(found(yes)).
guess(weedle)		:- weedle, assert(found(yes)).
guess(kakuna)		:- kakuna, assert(found(yes)).
guess(beedrill)		:- beedrill, assert(found(yes)).
guess(pidgey)		:- pidgey, assert(found(yes)).
guess(pidgeotto)	:- pidgeotto, assert(found(yes)).
guess(pidgeot)		:- pidgeot, assert(found(yes)). 
guess(rattata)		:- rattata, assert(found(yes)).
guess(raticate)		:- raticate, assert(found(yes)).
guess(spearow)		:- spearow, assert(found(yes)).
guess(fearow)		:- fearow, assert(found(yes)).
guess(ekans)		:- ekans, assert(found(yes)).
guess(arbok)		:- arbok, assert(found(yes)).
guess(pikachu)		:- pikachu, assert(found(yes)).
guess(raichu)		:- raichu, assert(found(yes)).
guess(sandshrew)	:- sandshrew, assert(found(yes)).
guess(sandslash)	:- sandslash, assert(found(yes)).
guess(nidoranF)		:- nidoranF, assert(found(yes)).
guess(nidorina)		:- nidorina, assert(found(yes)).
guess(nidoqueen)	:- nidoqueen, assert(found(yes)).
guess(nidoranM)		:- nidoranM, assert(found(yes)).
guess(nidorino)		:- nidorino, assert(found(yes)).
guess(nidoking)		:- nidoking, assert(found(yes)).
guess(clefairy)		:- clefairy, assert(found(yes)).
guess(clefable)		:- clefable, assert(found(yes)).
guess(vulpix)		:- vulpix, assert(found(yes)).
guess(ninetails)	:- ninetails, assert(found(yes)).
guess(jigglypuff)	:- jigglypuff, assert(found(yes)).
guess(wigglytuff)	:- wigglytuff, assert(found(yes)).
guess(zubat)		:- zubat, assert(found(yes)).
/*DEFAULT STATEMENT*/
guess(unidentified)	:- not(found(yes)).


/**************************************************************************
 * POKEMON DEFINITIONS:
 *   Defines Pokemon in terms of their attributes.
 **************************************************************************/
bulbasaur 	:- type(grass),
		   heightCM(71),
		   weightG(6900).
bulbasaur 	:- type(poison),
		   heightCM(71),
		   weightG(6900).
ivysaur		:- type(grass),
		   heightCM(99),
		   weightG(13000).
ivysaur		:- type(poison),
		   heightCM(99),
		   weightG(13000).
venusaur	:- type(grass),
		   heightCM(201),
		   weightG(100000).
venusaur	:- type(poison),
		   heightCM(201),
		   weightG(100000).
charmander 	:- type(fire),
		   heightCM(61),
		   weightG(8500).
charmeleon	:- type(fire),
		   heightCM(109),
		   weightG(19000).
charizard	:- type(fire),
		   heightCM(170),
		   weightG(90500).
charizard	:- type(flying),
		   heightCM(170),
		   weightG(90500).
squirtle 	:- type(water),
		   heightCM(51),
		   weightG(9000).
wartortle	:- type(water),
		   heightCM(99),
		   weightG(22500).
blastoise	:- type(water),
		   heightCM(160),
		   weightG(85500).
caterpie	:- type(bug),
		   heightCM(30),
		   weightG(2900).
metapod		:- type(bug),
		   heightCM(71),
		   weightG(9900).
butterfree	:- type(bug),
		   heightCM(109),
		   weightG(3200).
butterfree	:- type(flying),
		   heightCM(109),
		   weightG(3200).
weedle		:- type(bug),
		   heightCM(30),
		   weightG(3200).
weedle		:- type(poison),
		   heightCM(30),
		   weightG(3200).
kakuna		:- type(bug),
		   heightCM(61),
		   weightG(10000).
kakuna		:- type(poison),
		   heightCM(61),
		   weightG(10000).
beedrill	:- type(bug),
		   heightCM(99),
		   weightG(29500).
beedrill	:- type(poison),
		   heightCM(99),
		   weightG(29500).
pidgey		:- type(normal),
		   heightCM(30),
		   weightG(1800).
pidgey		:- type(flying),
		   heightCM(30),
		   weightG(1800).
pidgeotto	:- type(normal),
		   heightCM(109),
		   weightG(30000).
pidgeotto	:- type(flying),
		   heightCM(109),
		   weightG(30000).
pidgeot		:- type(normal),
		   heightCM(150),
		   weightG(39500).
pidgeot		:- type(normal),
		   heightCM(150),
		   weightG(39500).
rattata		:- type(normal),
		   heightCM(30),
		   weightG(35000).
raticate	:- type(normal),
		   heightCM(71),
		   weightG(18500).
spearow		:- type(normal),
		   heightCM(30),
		   weightG(2000).
spearow		:- type(flying),
		   heightCM(30),
		   weightG(2000).
fearow		:- type(normal),
		   heightCM(119),
		   weightG(38000).
fearow		:- type(flying),
		   heightCM(119),
		   weightG(38000).
ekans		:- type(poison),
		   heightCM(201),
		   weightG(6900).
arbok		:- type(poison),
		   heightCM(351),
		   weightG(65000).
pikachu		:- type(electric),
		   heightCM(41),
		   weightG(6000).
raichu		:- type(electric),
		   heightCM(79),
		   weightG(30000).
sandshrew	:- type(ground),
		   heightCM(61),
		   weightG(12000).
sandslash	:- type(ground),
		   heightCM(99),
		   weightG(29500).
nidoranF	:- type(poison),
		   heightCM(41),
		   weightG(7000).
nidorina	:- type(poison),
		   heightCM(79),
		   weightG(20000).
nidoqueen	:- type(poison),
		   heightCM(130),
		   weightG(60000).
nidoqueen	:- type(ground),
		   heightCM(130),
		   weightG(60000).
nidoranM	:- type(poison),
		   heightCM(51),
		   weightG(9000).
nidorino	:- type(poison),
		   heightCM(89),
		   weightG(19500).
nidoking	:- type(poison),
		   heightCM(140),
		   weightG(62000).
nidoking	:- type(ground),
		   heightCM(140),
		   weightG(62000).
clefairy	:- type(fairy),
		   heightCM(61),
		   weightG(7500).
clefable	:- type(fairy),
		   heightCM(130),
		   weightG(40000).
vulpix		:- type(fire),
		   heightCM(61),
		   weightG(9900).
ninetails	:- type(fire),
		   heightCM(109),
		   weightG(19900).
jigglypuff	:- type(normal),
		   heightCM(51),
		   weightG(5500).
jigglypuff	:- type(fairy),
		   heightCM(51),
		   weightG(5500).
wigglytuff	:- type(normal),
		   heightCM(99),
		   weightG(12000).
wigglytuff	:- type(fairy),
		   heightCM(99),
		   weightG(12000).
zubat		:- type(poison),
		   heightCM(79),
		   weightG(7500).
zubat		:- type(flying),
		   heightCM(79),
		   weightG(7500).


/**************************************************************************
 * INADEQUACY DISCUSSION:
 *   A discussion of the things that are missing in the system.
 **************************************************************************
 This system would benefit from the following features:
   Added attributes:
     This system could become more accurate if we added an attribute for color,
       or species.
     Added attributes mean that we know more about the subject matter at hand 
       and can better identify the things we are talking about; therefore 
       reducing the number of answers that we receive in response to queries
       and information provided.
     Special attributes such as "has_flower" or "has_shell", that can be verified
       by a query to the user, could also help reduce the number of answers 
       received from the system; therefore making the system responses more 
       accurate.
     To extend this system for a general attribute such as color, I would add 
       in the attribute on the individual Pokemon, and query the user for 
       this information. 
     To extend this system to verify for special attributes I would add a
       predicate that asks the user for a yes or no response about whether a 
       Pokemon had the attribute in question.
     Once extra attributes were added, features such as certainty factors would
       be more effective in determining how accurate the guess is. 
   Guess ranking system:
     Once the above "added features" section was implemented, this system
       would benefit from having an information ranking system, so displaying
       the top guesses in order based on their certainty factors. Extra work 
       could be done to just display the top three options at the end of the 
       search.
     To extend this system for certainty factors, I would apply certainty 
       factors provided by the user to the individual attributes, and weight 
       each of the responses based on what the certainty factor was for. Example
       color is likely more important than weight or height as it is easier to 
       observe color. 
   Reverse lookup:
     A nice feature would be the ability to look a Pokemon up by name and have
       the details about that Pokemon be output to the screen. 
     This could be further extended by having a "similar" predicate to find 
       Pokemon similar to the name of the one entered into the system by the
       user.
     To extend this sytem I would add new predicates that complete a different
       search based on name.
 */
