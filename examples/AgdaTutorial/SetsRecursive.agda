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

data ℕ₂ : Set where
  zero : ℕ₂
  id   : ℕ⁺ → ℕ₂


-- Can't do this sinc  ℕ⁺ doesn't have 0:
-- ℕ₂Toℕ⁺ : ℕ₂ → ℕ⁺
-- ℕ₂Toℕ⁺  zero = ???
-- ℕ₂Toℕ⁺ (id n) = n

ℕ⁺Toℕ : ℕ⁺ → ℕ
ℕ⁺Toℕ one = suc(zero)
ℕ⁺Toℕ (double n) = (ℕ⁺Toℕ n) + (ℕ⁺Toℕ n)
ℕ⁺Toℕ (double+1 n) = suc(ℕ⁺Toℕ n)

ℕ₂Toℕ : ℕ₂ → ℕ
ℕ₂Toℕ zero = zero
ℕ₂Toℕ (id n) = ℕ⁺Toℕ n

-- TODO: ℕToℕ₂ : ℕ → ℕ₂

-- -- To pick ℕ or ℕ₂ -- -- 
-- n * 2

mul2 : ℕ₂ → ℕ₂
mul2 zero = zero
mul2 (id n) = id (double n)

-- mul2 : ℕ → ℕ
-- mul2 zero = zero
-- mul2 (id n) = id (double n)



