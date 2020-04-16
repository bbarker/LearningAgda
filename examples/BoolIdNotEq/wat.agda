-- Taken from:
-- https://semantic-domain.blogspot.com/2016/03/agda-is-not-purely-functional-language.html?m=1

module wat where 

open import Data.Bool
open import Relation.Binary.PropositionalEquality using (_≡_; refl)

-- Next, let's define the identity function on booleans.


f : Bool → Bool
f true = true
f false = false

-- In fact, let's define it a second time!

g : Bool → Bool
g true = true
g false = false

-- So now we have two definitions of the identity function f, and g, so they must be equal, right? Let's see if we can write a proof this fact.

wat : f ≡ g 
wat = refl

