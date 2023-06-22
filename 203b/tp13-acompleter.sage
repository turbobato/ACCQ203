print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP13 : COURBES ELLIPTIQUES                                                  #
# *************************************************************************** #
# *************************************************************************** #
""")

# CONSIGNES
#
# Les seules lignes a modifier sont annoncee par "Code pour l'exercice"
# indique en commmentaire et son signalees
# Ne changez pas le nom des variables
#
# CONSEILS
#
# Ce modele vous sert a restituer votre travail. Il est deconseille d'ecrire
# une longue suite d'instruction et de debugger ensuite. Il vaut mieux tester
# le code que vous produisez ligne apres ligne, afficher les resultats et
# controler que les objets que vous definissez sont bien ceux que vous attendez.
#
# Vous devez verifier votre code en le testant, y compris par des exemples que
# vous aurez fabrique vous-meme.
#


reset()
print("""\
# ****************************************************************************
# ADDITION DANS UNE COURBE ELLIPTIQUE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

p = 61
Fp = FiniteField(p)
E = EllipticCurve(Fp,[1,0])
P = E.random_point()
Q = E.random_point()

# Code pour l'EXERCICE

def addition(P,Q):
    E = P.curve()
    Fp = E.base_ring()
    a = E.a4()
    b = E.a6()
    return a,b #FAIRE LE CALCUL DU POINT

# # Affichage des resultats

addition(P,Q)


reset()
print("""\
# ****************************************************************************
# COURBE DE L'ANSSI
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


# Code pour l'EXERCICE

ANSSI = "acronyme"
p = 3
a = 1
b = 1
E = EllipticCurve(FiniteField(p),[a,b])

# # Affichage des resultats

print "ANSSI signifie :",ANSSI
print "La courbe recommandée est"
print E 
print p.is_prime()




reset()
print("""\
# ****************************************************************************
# COMPTAGE DE POINTS
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

p = 2003
Fp = FiniteField(p)
a = 1929
b = 1178

while true:
    d=Fp.random_element()
    if not d.is_square():
        break


# Code pour l'EXERCICE

def comptage(a,b):
    return 0

frequence = [4,1,4]

# # Affichage des resultats

print comptage(a,b)
bar_chart(frequence)


reset()
print("""\
# ****************************************************************************
# FACTORISATION ECM
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

class FoundFactor(Exception):
    def __init__(self, value):
        self.value = value
    def __str__(self):
        return repr(self.value)

n = Zmod(2020)

# Code pour l'EXERCICE

def division(x,y):
    n = y.modulus()
    return 0

def addition(P,Q):
    E = P.curve()
    return E(0)   
    
def multiplication(lamb,P): 
    E = P.curve()
    return E(0)   

def ECM(n,B):
    return True


# # Affichage des resultats

ECM(n,15)


reset()
print("""\
# ****************************************************************************
# EXPONENTIATION RAPIDE ET ATTAQUE PAR CANAUX CACHES
# ****************************************************************************
""")

# NE PAS TRAITER



reset()
print("""\
# ****************************************************************************
# COURBE D'EDWARDS
# ****************************************************************************
""")



# Code pour l'EXERCICE

reponse = "A completer"

# # Affichage des resultats

print reponse

