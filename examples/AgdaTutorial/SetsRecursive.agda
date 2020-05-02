module SetsRecursive where

data ℕ : Set where
  zero : ℕ
  suc : ℕ -> ℕ

_+_ : ℕ → ℕ → ℕ
zero + n = n
(suc m) + n = suc (m + n)

data ℕ⁺ : Set where
  one      : ℕ⁺
  double   : ℕ⁺ → ℕ⁺
  double+1 : ℕ⁺ → ℕ⁺

-- This seems difficult to do without `suc`: we seem to get termination checking issues
-- We could add `suc` as a data constructor
-- for ℕ⁺, then prove later that (suc n) = n + one.
-- _+⁺_ : ℕ⁺ → ℕ⁺ → ℕ⁺
-- one +⁺ one = double one
-- (double m) +⁺ (double n) = double (m +⁺ n)
-- (double+1 m) +⁺ (double+1 n) = double ((m +⁺ n) +⁺ one)
-- one +⁺ (double n) = double+1 n
-- one +⁺ (double+1 n) = double (n +⁺ one)
-- (double m) +⁺ (double+1 n) = double+1 (m +⁺ n)
-- -- And add commutativity:
-- (double n) +⁺ one = double+1 n
-- (double+1 n) +⁺ one = double (n +⁺ one)
-- (double+1 n) +⁺ (double m) = double+1 (m +⁺ n)

data ℕ₂ : Set where
  zero : ℕ₂
  id   : ℕ⁺ → ℕ₂


-- Can't do this since  ℕ⁺ doesn't have 0:
-- ℕ₂Toℕ⁺ : ℕ₂ → ℕ⁺
-- ℕ₂Toℕ⁺  zero = ???
-- ℕ₂Toℕ⁺ (id n) = n

-- | Sends 0 to 1!
unsafeℕ₂Toℕ⁺ : ℕ₂ → ℕ⁺
unsafeℕ₂Toℕ⁺ zero = one
unsafeℕ₂Toℕ⁺ (id n) = n

-- -- | Sends 0 to 1!
-- unsafeℕToℕ⁺ : ℕ₂ → ℕ⁺
-- unsafeℕToℕ⁺ zero = one
-- unsafeℕToℕ⁺ (suc n) = ? -- need to recurse

ℕ⁺Toℕ : ℕ⁺ → ℕ
ℕ⁺Toℕ one = suc(zero)
ℕ⁺Toℕ (double n) = (ℕ⁺Toℕ n) + (ℕ⁺Toℕ n)
ℕ⁺Toℕ (double+1 n) = suc(ℕ⁺Toℕ n)

ℕ₂Toℕ : ℕ₂ → ℕ
ℕ₂Toℕ zero = zero
ℕ₂Toℕ (id n) = ℕ⁺Toℕ n

-- Similar to the above _+⁺_, this seems difficult to implement without `suc` for ℕ⁺
-- But, we can use `unsafeℕ₂Toℕ⁺` ? Either way seems like we need to make use of "native"
-- integer matht o recurse down and find "half of n" ... hmm
-- ℕToℕ₂ : ℕ → ℕ₂
-- ℕToℕ₂ zero = zero
-- ℕToℕ₂ (suc n) = id (one + )



-- -- To pick ℕ or ℕ₂ -- --

-- | n * 2  (ℕ₂ is the winner)
mul2 : ℕ₂ → ℕ₂
mul2 zero = zero
mul2 (id n) = id (double n)
-- 
-- mul2n : ℕ → ℕ
-- mul2n zero = zero
-- mul2n (suc n) = ℕ⁺Toℕ ( double (unsafeℕToℕ⁺ (suc n)) )


data ℤ : Set where
  zero : ℤ
  pos : ℕ⁺ -> ℤ
  neg : ℕ⁺ -> ℤ

--- Binary Trees ---

data BinTree : Set where
  leaf : ℕ → BinTree
  node : BinTree → BinTree → ℕ → BinTree

data [ℕ] : Set where
  Nil : [ℕ]
  :: : ℕ → [ℕ] → [ℕ]

