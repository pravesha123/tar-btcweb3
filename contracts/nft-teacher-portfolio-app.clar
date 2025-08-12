;; Teacher Portfolio DApp - NFT Showcasing Impacts/Stats
;; Using Clarity Language

;; Define the NFT
(define-non-fungible-token teacher-achievement uint)

;; Store teacher achievement details
(define-map achievement-details uint
  {
    teacher-name: (string-ascii 50),
    achievement-title: (string-ascii 100),
    impact-score: uint
  }
)

;; Keep track of next NFT ID
(define-data-var next-id uint u1)

;; --------------------------
;; Function 1: Mint Achievement NFT
;; --------------------------
(define-public (mint-achievement
    (teacher-name (string-ascii 50))
    (achievement-title (string-ascii 100))
    (impact-score uint)
    (recipient principal))
  (let ((id (var-get next-id)))
    (begin
      (try! (nft-mint? teacher-achievement id recipient))
      (map-set achievement-details id
        {
          teacher-name: teacher-name,
          achievement-title: achievement-title,
          impact-score: impact-score
        })
      (var-set next-id (+ id u1))
      (ok id)
    )
  )
)

;; --------------------------
;; Function 2: View Achievement Details
;; --------------------------
(define-read-only (get-achievement (id uint))
  (ok (map-get? achievement-details id))
)
