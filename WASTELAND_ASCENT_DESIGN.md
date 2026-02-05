# WASTELAND ASCENT – Design Document

## 1. Spilkoncept og pitch

**"Wasteland Ascent"** er en roguelike deck-builder, hvor spilleren klatrer gennem zonerne i et forstrålet atombunker-kompleks. Du bygger dit deck af improviserede våben, gadgets og overlevelsestricks, og kæmper mod mutanter, raiders og defekte robotter. Hver death sender dig tilbage til bunden, men du beholder viden og ressourcer til at låse nye kort og relics op.

**Hook:** Fallouts melankolske humor + Slay the Spires taktiske kortspil = *"Én mere run, så finder jeg nok den smeltebrænder..."*

---

## 2. Setting og verden

**Bunker Complex 7** er en gigantisk underjordisk facilitet bygget før krigen. Spilleren starter i **Level 0** (nederste etage) og skal nå **Level 5** (udgangen til overfladen).

### Stemning
- Rust, flimrende neonlys og dampende rør
- Retro-futuristisk teknologi (rør-computere, nixie-rør-displays)
- Gallows humor i item-beskrivelser (*"Kun 40% chance for tetanus!"*)
- Håbløshed blandet med absurd optimisme

### Zonetyper (simplificeret til prototype)
- **Depot Zones:** Industri-områder med maskiner, raiders og loot
- **Medical Zones:** Sygehus-afsnit med mutanter og healing events
- **Command Zones:** Kontrolrum med robotter og teknologi-relics

---

## 3. Spilleren / helten

**Character:** *The Scavenger*

- **Startdeck:** 10 kort (se sektion 5)
- **Start HP:** 50
- **Startressourcer:** 0 scrap

### Ressourcer pr. kamp
- **Action Points (AP):** 3 pr. tur (energisystem, som i Slay the Spire)
- **HP:** Persistenter gennem run (healer kun ved bonfires/events)

### Særlige mekanikker
**Radiation Counter:** Nogle kort giver *Rads*. Ved **10 Rads**:
1. Mist 3 max HP permanent i dette run
2. Rads resetter til 0
3. Giver adgang til kraftige *Irradiated*-kort

---

## 4. Core gameplay-loop

Et komplet run (simplificeret prototype):

```text
START RUN
  ↓
Choose starting bonus (1 of 3 random relics)
  ↓
FLOOR 1-3: Combat encounters
  → Efter hver: Vælg 1 af 3 tilfældige kort til deck
  → Tjek scrap loot
  ↓
FLOOR 4: Shop (køb kort/relics med scrap)
  ↓
FLOOR 5-7: Combat encounters + 1 random event
  ↓
FLOOR 8: Mini-boss
  → Vælg 1 af 3 rare kort + relic reward
  ↓
FLOOR 9-10: Combat
  ↓
FLOOR 11: Bonfire (heal 20 HP, remove 1 card fra deck)
  ↓
FLOOR 12-14: Combat
  ↓
FLOOR 15: FINAL BOSS
  ↓
Victory → unlock new cards/relics for future runs
```

### Node-typer i prototype
- **Combat (70%):** Standard kamp
- **Event (15%):** Vælg-selv-eventyr (heal vs. relic, risk vs. reward)
- **Shop (10%):** Køb med scrap
- **Bonfire (5%):** Heal + remove card

---

## 5. Kortsystem

### Startdeck (10 kort)
| Kortnavn | Type | Cost | Effect |
|---|---|---|---|
| Rusty Pipe | Attack | 1 AP | Deal 6 damage |
| Rusty Pipe | Attack | 1 AP | Deal 6 damage |
| Rusty Pipe | Attack | 1 AP | Deal 6 damage |
| Rusty Pipe | Attack | 1 AP | Deal 6 damage |
| Shove | Attack | 1 AP | Deal 4 damage |
| Scrap Shield | Defend | 1 AP | Gain 5 Block |
| Scrap Shield | Defend | 1 AP | Gain 5 Block |
| Scrap Shield | Defend | 1 AP | Gain 5 Block |
| Scrap Shield | Defend | 1 AP | Gain 5 Block |
| Duck & Cover | Defend | 1 AP | Gain 3 Block. Draw 1 card |

### Findable cards (15 eksempler)

#### Attack Cards
| Navn | Cost | Effect | Rarity |
|---|---|---|---|
| Molotov | 2 AP | Deal 10 dmg. Apply 3 Burn | Common |
| Shotgun Blast | 2 AP | Deal 14 damage | Common |
| Jury-Rigged Taser | 1 AP | Deal 5 dmg. Apply 1 Stun | Common |
| Nail Bomb | 3 AP | Deal 20 dmg. Gain 2 Rads | Uncommon |
| Plasma Cutter | 2 AP | Deal 8 dmg twice | Uncommon |
| Meltdown | 3 AP | Deal 30 dmg. Gain 5 Rads. Exhaust | Rare |

#### Defend Cards
| Navn | Cost | Effect | Rarity |
|---|---|---|---|
| Riot Shield | 2 AP | Gain 12 Block | Common |
| Gas Mask | 1 AP | Gain 6 Block. Ignore 1 Rad this turn | Common |
| Bunker Down | 2 AP | Gain 15 Block. Cannot attack next turn | Uncommon |
| Lead Vest | 3 AP | Gain 20 Block. Lose 1 AP next turn | Rare |

#### Utility Cards
| Navn | Cost | Effect | Rarity |
|---|---|---|---|
| Stimpack | 1 AP | Heal 8 HP | Common |
| Scavenge | 1 AP | Gain 5 scrap. Draw 1 card | Common |
| Adrenaline Shot | 0 AP | Draw 2 cards. Gain 1 Rad | Uncommon |
| Radioactive Mutation | 2 AP | Gain 3 Rads. +2 Strength rest of combat | Rare |

### Build synergies (3 simple archetypes)
1. **Radiation Build**
   - Stack Rads intentionelt for power
   - Cards: Nail Bomb, Meltdown, Adrenaline Shot, Radioactive Mutation
   - Relic synergy: *Geiger Badge* (Deal +3 dmg per Rad counter)

2. **Burn / DOT Build**
   - Apply Burn debuff og chip fjender ned
   - Cards: Molotov, Fire Axe (imagined upgrade), Burn-applying relics
   - Relic synergy: *Flamethrower Fuel* (Burn damage doubled)

3. **Block / Tank Build**
   - Høj defense, outlast fjender
   - Cards: Riot Shield, Lead Vest, Bunker Down
   - Relic synergy: *Reinforced Plating* (+3 Block per card played)

---

## 6. Relics og ressourcer

### Valuta
- **Scrap:** Tjenes fra kampe (5–15 per fight). Bruges i shop.

### Relics (12 eksempler)
| Relic navn | Effect | Tier |
|---|---|---|
| Rusty Canteen | Heal 3 HP after each combat | Common |
| Lucky Bullet Casing | +10% chance for double damage | Common |
| Duct Tape | First time you would die, survive with 1 HP | Rare |
| Geiger Badge | Deal +3 dmg per Rad counter | Uncommon |
| Flamethrower Fuel | Burn effects deal double damage | Uncommon |
| Reinforced Plating | Gain +3 Block whenever you play a card | Uncommon |
| Moonshine Flask | Heal 5 HP. Gain 1 Rad at start of combat | Common |
| Pre-War Compass | Reveal next 3 floors at start of run | Rare |
| Scrap Magnet | Gain +5 scrap after each combat | Common |
| Robot Chip | Deal +50% damage to Robot enemies | Common |
| Irradiated Blood | Start each combat with 2 Rads, +5 Max HP | Rare |
| Medical Kit | Healing effects +50% | Uncommon |

---

## 7. Fjender og bosser

### Basic enemies (3 typer)

#### Raider Scum
- **HP:** 25
- **Pattern:** Attack 6 dmg → Attack 6 dmg → Defend 8 Block (repeat)
- **Loot:** 8 scrap

#### Feral Mutant
- **HP:** 30
- **Pattern:** Attack 10 dmg → Apply 2 Burn → Attack 10 dmg (repeat)
- **Loot:** 10 scrap

#### Security Bot
- **HP:** 35
- **Pattern:** Defend 10 Block → Attack 12 dmg → Attack 12 dmg (repeat)
- **Loot:** 12 scrap

### Mini-boss (1 eksempel)

#### Raider Warlord
- **HP:** 80
- **Pattern:**
  - Turn 1: Buff (+3 Strength)
  - Turn 2–3: Attack 15 dmg
  - Turn 4: AOE attack 8 dmg + Apply 2 Burn
  - Repeat fra turn 2
- **Loot:** 30 scrap + choice of rare card

### Final Boss

#### The Overseer Unit (malfunctioning AI robot)
- **HP:** 150
- **Pattern (3 phases):**
  - **Phase 1 (HP 150–100):** Attack 12 → Defend 15 → Attack 12
  - **Phase 2 (HP 99–50):** Summon 1 Security Bot → Attack 18 → Attack 18
  - **Phase 3 (HP 49–0):** Attack 25 → Apply 5 Burn → Gain 20 Block
- **Loot:** Victory unlocks 5 new cards + 2 new relics for future runs

---

## 8. Progression uden for runs (meta-progression)

### Unlock system
Efter hver run (victory eller death efter floor 8+):
- Earn Tokens baseret på floors cleared (1 token per 3 floors)
- Spend tokens i **Shelter Hub** (main menu)

| Unlock | Cost | Effect |
|---|---|---|
| New Card: Sawed-Off Shotgun | 3 tokens | Tilføj til card pool |
| New Card: Rad-Away | 2 tokens | Tilføj til card pool |
| New Relic: Vault Key | 5 tokens | Start runs med +10 scrap |
| New Character (future) | 10 tokens | Locked for v0.1 |
| Difficulty: Irradiated Mode | 8 tokens | Enemies +20% HP, better loot |

### No meta-stat boosts
- Ingen permanente HP/damage increases
- Kun unlocks af nye build-muligheder (kort/relics)
- Bevarer roguelike *"skill > grinding"*-filosofi

---

## 9. Teknisk scope – Prototype v0.1

### ✅ MUST HAVE (Version 0.1)

#### Core systems
- Turn-based card combat engine
- Draw 5 cards per turn, 3 AP per turn
- Deck shuffling (draw pile → discard → reshuffle)
- HP, Block (resets each turn), damage calculation
- Enemy AI patterns (fixed rotation)

#### Content
- 1 character (*The Scavenger*)
- 10 starting cards
- 8–10 findable cards (attack, defend, utility mix)
- 3 enemy types
- 1 mini-boss
- 1 final boss
- 6 relics (3 common, 2 uncommon, 1 rare)

#### Run structure
- 15-floor linear path
- 3 node types: Combat, Shop, Bonfire
- Victory/death screen med token rewards

#### UI
- Hand display (5 cards)
- Enemy intent display (what they'll do next turn)
- HP/AP counters
- Deck/discard pile counters
- Card reward screen (pick 1 of 3)

### ⏸️ NICE TO HAVE (Version 0.2+)

#### Systems
- Branching path map (a la Slay the Spire)
- Random events with choices
- Card upgrades (+ versions)
- Flere debuffs (Poison, Weak, Vulnerable)
- Relic synergies med VFX

#### Content
- 2nd character class
- 20+ more cards
- 10+ more relics
- 5+ more enemies
- 2nd boss

#### Meta
- Daily run challenges
- Achievements
- Stats tracking (wins, losses, fastest run)

### ❌ NOT IN SCOPE (Ver 1.0+)
- Multiplayer/co-op
- Full story campaign
- Voice acting
- Animated card art (start med static images/icons)
- Mobile touch controls (build PC/web first, port later)

---

## Data structure cheat sheet (for coding)

### Card object
```javascript
{
  id: "rusty_pipe",
  name: "Rusty Pipe",
  type: "attack",
  cost: 1,
  effects: [
    { type: "damage", value: 6 }
  ],
  rarity: "starter"
}
```

### Enemy object
```javascript
{
  id: "raider_scum",
  name: "Raider Scum",
  hp: 25,
  pattern: [
    { intent: "attack", value: 6 },
    { intent: "attack", value: 6 },
    { intent: "defend", value: 8 }
  ],
  loot: { scrap: 8 }
}
```

### Relic object
```javascript
{
  id: "rusty_canteen",
  name: "Rusty Canteen",
  description: "Heal 3 HP after each combat",
  trigger: "post_combat",
  effect: { type: "heal", value: 3 }
}
```
