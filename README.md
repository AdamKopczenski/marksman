# marksman
A more strategic version of the classic game of hangman

## A Sample Game
This is probably the easiest way to demonstrate the game's rules. The game is run on a terminal.

```
akopczenski@mampara:~$ marksman
"‗'__ _____ ____ _ ___________ ___ _ ____ ____ ‗'_ __ _______ __ __." -- ‗______ ‗_____
Guess #1:  
```

So far, this just looks like Hangman. As a small favor to the player, any capitalized letters in the puzzle are indicated with double underscores. Let's start by guessing a few common letters:

```
Guess #1: e
"‗'__ _____ __e_ _ ___________ ___ ‗ ____ ____ ‗'_ __ _______ __ __." -- ‗______ ‗_____
Guess #2: r
"‗'__ ____r __e_ _ ___________ ___ ‗ ____ ____ ‗'_ __ _______ __ __." -- ‗______ ‗_____
Guess #3: s
"‗'__ ____r __e_ _ ___________ ___ ‗ __s_ ____ ‗'_ __ _______ __ __." -- ‗______ ‗_____
Guess #4: t
"‗'__ ____r __e_ _ ___________ ___ ‗ __st ____ ‗'_ __ _______ __ __." -- ‗______ ‗_____
Guess #5: n
"‗'__ ____r __e_ _ ___________ ___ ‗ __st ____ ‗'_ __ _____n_ __ __." -- ‗______ ‗_____
Guess #6:  
```

Here's the twist: when you guess a letter correctly, the game only fills in one copy of the letter in the puzzle. In order to reveal the others, we need to repeat guesses.

```
Guess #6: e
"‗'__ ____r __e_ _ ___________ ___ ‗ __st ____ ‗'_ __ _____n_ __ __." -- ‗______ ‗___e_
Guess #7: e
"‗'__ ____r _ee_ _ ___________ ___ ‗ __st ____ ‗'_ _e _____n_ __ __." -- ‗______ ‗___e_
Guess #8: 
```

This is going to take forever. Fortunately, we can speed it up by putting more than one letter in a single guess. Unfortunately, the entire guess will be rejected (and no progress will be made) if even a single extra copy of one letter is present in a guess.

```
Guess #8: rrttnnaaiiil
All letters from "rrttnnaaiiil" in answer!
"‗'__ ____r _een a ___l__nair_ __t I __st ____ ‗'_ _e _____n_ __ i_." -- ‗___t__ ‗___er
Guess #9: ieim
All letters from "ieim" in answer!
"I'__ _e__r _een a mi_l__nair_ __t I __st ____ ‗'_ _e _____n_ __ i_." -- ‗___t__ ‗___er
Guess #10: lioeixqj
Not all letters from "lioeixqj" in answer.
"I'__ _e__r _een a mi_l__nair_ __t I __st ____ ‗'_ _e _____n_ __ i_." -- ‗___t__ ‗___er
Guess #11: lioei
All letters from "lioei" in answer!
"I'__ _e_er _een a milli_nair_ __t I __st ____ I'_ _e _____n_ __ i_." -- ‗__ot__ ‗___er
Guess #12: 
```

Notice a few things about our recent guesses. It turns out that the order of letters in our guesses don't matter: guessing "aeiou" is equivalent to guessing "ueiao" or any other permutation. Also, the game treats capital and lowercase letters the same for purposes of filling in guesses.

That's about it for the rules of the game. It'll continue until we reveal the entire quotation and simply count how many guesses we needed to make. That's all the game has for feedback or a scoring system, which means that the only penalty for a bad guess is a single "point," but I find this is already a pretty satisfying gameplay experience.

The rest of this section contains strategy tips and eventually the solution to our sample puzzle. You may want to skip it and figure it out on your own.

<details><summary>The rest of the game</summary><p>

It's a good strategy to take advantage of the game's random reveal order. If we figure out a single word, we can make repeated guesses at it to make progress elsewhere. It's pretty obvious that the fourth word in our quotation is *millionaire*.

```
Guess #13: oe
All letters from "oe" in answer!
"I'__ _e_er _een a milli_naire __t I __st ____ I'_ _e _____n_ __ i_." -- ‗o_ot__ ‗___er
Guess #14: o
All letters from "o" in answer!
"I'__ _e_er _een a millionaire __t I __st ____ I'_ _e _____n_ __ i_." -- ‗o_ot__ ‗___er
Guess #15:
```

Now *millionaire* is completed and we've gotten a little extra help on the speaker's name. The same technique can work with several words at once. The quotation starts with *I've never*, and the word after *millionaire* is *but*.

```
Guess #15: venvbu
All letters from "venvbu" in answer!
"I've _ever been a millionaire _ut I __st _n__ I'_ _e _____n_ __ i_." -- ‗o_ot__ ‗___er
Guess #16: nb
All letters from "nb" in answer!
"I've never been a millionaire _ut I __st _n__ I'_ be _____n_ __ i_." -- ‗o_ot__ ‗___er
Guess #17: nb
All letters from "b" in answer!
"I've never been a millionaire but I __st _n__ I'_ be _____n_ __ i_." -- ‗o_ot__ ‗___er
Guess #18: 
```

We can't be 100% certain that we've found every *b*, *e*, *n*, *o*, *u*, and *v* in the puzzle just because the section we've been harping on is complete, but it's a nice start. And we finished the words *been* and *be* thanks to our repetition!

Looking at the board now, it's pretty likely that:
 - The first word with any blanks left is either *must* or *just*. Either way, a *u* is a safe bet.
 - The only incomplete contraction is *I'd*. ("I'm be" doesn't make sense.)
 - the last word in the quotation is *it*. (*If* and *is* rarely end sentences.)

Let's use the repetition technique to add this to the puzzle.

```
Guess #18: udt
All letters from "udt" in answer!
"I've never been a millionaire but I _ust _n__ I'_ be _____n_ _t i_." -- Do_ot__ ‗___er
Guess #19: dt
All letters from "dt" in answer!
"I've never been a millionaire but I _ust _n__ I'd be _____n_ _t it." -- Do_ot__ ‗___er
Guess #20:
```

The extra *d* is a big help: the speaker's first name is Dorothy! (Also, the sentence ends in *at it*.)

```
Guess #20: arhy
All letters from "rhy" in answer!
"I've never been a millionaire but I _ust _n__ I'd be _a___n_ _t it." -- Do_othy ‗_r_er
Guess #21: ar
All letters from "r" in answer!
"I've never been a millionaire but I _ust _n__ I'd be _ar__n_ at it." -- Do_othy ‗_r_er
Guess #21: r
All letters from "r" in answer!
"I've never been a millionaire but I _ust _n__ I'd be _ar__n_ at it." -- Dorothy ‗_r_er
Guess #22:
```

Let's try *must* for *\_ust*.
```
Guess #22: m
Not all letters from "m" in answer.
"I've never been a millionaire but I _ust _n__ I'd be _ar__n_ at it." -- Dorothy ‗_r_er
Guess #23:
```

A wasted guess! But we've learned that the letter *m* is totally done with in the puzzle. We'll make a mental note to avoid using it at any point in the future, and we'll try *just* as the word in question. 

```
Guess #23: j
All letters from "j" in answer!
"I've never been a millionaire but I just _n__ I'd be _ar__n_ at it." -- Dorothy ‗_r_er
Guess #24:
```

The speaker is Dorothy Parker.

```
Guess #24: pak
All letters from "pak" in answer!
"I've never been a millionaire but I just kn__ I'd be _ar__n_ at it." -- Dorothy Par_er
Guess #25:
```

So far in our example game, we've been picking a small segment of the quotation and hammering on it until it's fully revealed. This has kept things a little clearer for teaching purposes. In a real game, we'd probably take a moment between successive guesses and fold new words in. Right, the fact that we're still owed a *k* in *Parker* can be registered at the same time as the fact that we can now identify the word *know* in the middle of the sentence.

```
Guess #25: kow
All letters from "kow" in answer!
"I've never been a millionaire but I just know I'd be _ar__n_ at it." -- Dorothy Parker
Guess #26: 
```

I'm out of tips to give in this space; I'm sure you'll have many other ideas as you play. For now, I'll finish our game in one shot.

```
Guess #26: dlig
All letters from "dlig" in answer!
"I've never been a millionaire but I just know I'd be darling at it." -- Dorothy Parker
You won in 26 guesses!
akopczenski@mampara:~$ 
```

</p></details>
