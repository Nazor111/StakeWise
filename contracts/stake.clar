;;StakeWise: DAO Investment Pool Smart Contract

;; Define constants
(define-constant contract-owner tx-sender)
(define-constant err-owner-only (err u100))
(define-constant err-not-enough-balance (err u101))
(define-constant err-invalid-proposal (err u102))
(define-constant err-proposal-expired (err u103))
(define-constant err-insufficient-stake (err u104))
(define-constant proposal-expiration-blocks u144)
(define-constant minimum-stake-to-vote u1000000) ;; 1 STX minimum stake to vote

;; Define data variables
(define-data-var total-pool-balance uint u0)
(define-data-var proposal-count uint u0)

;; Define data maps
(define-map balances principal uint)
(define-map proposals
  uint
  {
    id: uint,
    description: (string-ascii 256),
    amount: uint,
    votes-for: uint,
    votes-against: uint,
    status: (string-ascii 20),
    beneficiary: principal,
    created-at: uint
  }
)

;; Define owner-only modifier
(define-private (is-contract-owner)
  (is-eq tx-sender contract-owner)
)

;; Define functions
(define-public (stake (amount uint))
  (let ((current-balance (default-to u0 (map-get? balances tx-sender))))
    (if (>= (stx-get-balance tx-sender) amount)
      (begin
        (try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
        (map-set balances tx-sender (+ current-balance amount))
        (var-set total-pool-balance (+ (var-get total-pool-balance) amount))
        (ok true)
      )
      err-not-enough-balance
    )
  )
)

(define-public (unstake (amount uint))
  (let ((current-balance (default-to u0 (map-get? balances tx-sender))))
    (if (>= current-balance amount)
      (begin
        (try! (as-contract (stx-transfer? amount tx-sender tx-sender)))
        (map-set balances tx-sender (- current-balance amount))
        (var-set total-pool-balance (- (var-get total-pool-balance) amount))
        (ok true)
      )
      err-not-enough-balance
    )
  )
)

(define-public (create-proposal (description (string-ascii 256)) (amount uint) (beneficiary principal))
  (if (is-contract-owner)
    (let ((new-proposal-id (+ (var-get proposal-count) u1)))
      (map-set proposals new-proposal-id
        {
          id: new-proposal-id,
          description: description,
          amount: amount,
          votes-for: u0,
          votes-against: u0,
          status: "active",
          beneficiary: beneficiary,
          created-at: block-height
        }
      )
      (var-set proposal-count new-proposal-id)
      (ok new-proposal-id)
    )
    err-owner-only
  )
)

(define-public (vote (proposal-id uint) (vote-for bool))
  (let (
    (proposal (unwrap! (map-get? proposals proposal-id) err-invalid-proposal))
    (user-balance (default-to u0 (map-get? balances tx-sender)))
  )
    (asserts! (>= user-balance minimum-stake-to-vote) err-insufficient-stake)
    (asserts! (< (- block-height (get created-at proposal)) proposal-expiration-blocks) err-proposal-expired)
    (if vote-for
      (map-set proposals proposal-id
        (merge proposal { votes-for: (+ (get votes-for proposal) user-balance) })
      )
      (map-set proposals proposal-id
        (merge proposal { votes-against: (+ (get votes-against proposal) user-balance) })
      )
    )
    (ok true)
  )
)

(define-public (execute-proposal (proposal-id uint))
  (if (is-contract-owner)
    (let (
      (proposal (unwrap! (map-get? proposals proposal-id) err-invalid-proposal))
    )
      (asserts! (< (- block-height (get created-at proposal)) proposal-expiration-blocks) err-proposal-expired)
      (if (and
        (is-eq (get status proposal) "active")
        (> (get votes-for proposal) (get votes-against proposal))
      )
        (begin
          (try! (as-contract (stx-transfer? (get amount proposal) tx-sender (get beneficiary proposal))))
          (map-set proposals proposal-id
            (merge proposal { status: "executed" })
          )
          (ok true)
        )
        (err u104)
      )
    )
    err-owner-only
  )
)

;; Read-only functions
(define-read-only (get-balance (user principal))
  (default-to u0 (map-get? balances user))
)

(define-read-only (get-total-pool-balance)
  (var-get total-pool-balance)
)

(define-read-only (get-proposal (proposal-id uint))
  (map-get? proposals proposal-id)
)

(define-read-only (is-proposal-expired (proposal-id uint))
  (let (
    (proposal (unwrap! (map-get? proposals proposal-id) false))
  )
    (>= (- block-height (get created-at proposal)) proposal-expiration-blocks)
  )
)