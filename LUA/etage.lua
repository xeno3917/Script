-- Paramètres
local largeurTroue = 29
local hauteurTroue = 29
local epaisseurSol = 3
local intervalleEtages = 6

-- Fonction pour créer un sol à une hauteur spécifique
local function creerSol(hauteur)
    for i = 1, largeurTroue do
        for j = 1, epaisseurSol do
            turtle.digDown()
            turtle.placeDown()
            turtle.forward()
        end
        turtle.back(epaisseurSol)
        if i < largeurTroue then
            turtle.forward()
        end
    end
end

-- Fonction principale
local function creerEtages()
    for h = intervalleEtages, hauteurTroue, intervalleEtages do
        turtle.down(intervalleEtages)
        creerSol(h)
    end
end

-- Exécution du programme
creerEtages()
