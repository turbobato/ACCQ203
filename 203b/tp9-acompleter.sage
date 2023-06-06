print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP9 : FACTORISATION DES ENTIERS                                             #
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
# DIVISEURS SUCCESSIFS
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=2*3*3*5*5*5*7*11*11

# Code pour l'EXERCICE

def div_successives(n):
    return  n.prime_divisors()

# # Affichage des resultats

div_successives(n)
for n in range(2,10):
    assert(div_successives(ZZ(n))==ZZ(n).prime_divisors())


reset()
print("""\
# ****************************************************************************
# FACTORISATION D'UN NOMBRE B-FRIABLE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=2*3*3*5*5*5*7*11*11
P=[p for p in primes(12)]

# Code pour l'EXERCICE

def div_successives_friable(n, P):
    return  n.prime_divisors()

# # Affichage des resultats

div_successives_friable(n,P)
for n in range(2,10):
    assert(div_successives_friable(ZZ(n),P)==ZZ(n).prime_divisors())


reset()
print("""\
# ****************************************************************************
# RHO DE POLLARD
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=222763

# Code pour l'EXERCICE

def myPollardrho(n):
    x0=Integers(n).random_element()
    return True

# # Affichage des resultats

myPollardrho(n)

for _ in range(5):
    n=ZZ.random_element(3,100)
    print(n, 
      "| Resultat rho de Pollard : ", 
      myPollardrho(n), 
      " | n est-il composé ?",not n.is_prime())




reset()
print("""\
# ****************************************************************************
# P-1 DE POLLARD
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=1323269

# Code pour l'EXERCICE

def myPollardpm1(n):
    return True


# # Affichage des resultats

myPollardpm1(n)

for _ in range(5):
    n=ZZ.random_element(3,100)
    print(n, 
      "| Resultat rho de Pollard : ", 
      myPollardpm1(n), 
      " | n est-il composé ?",not n.is_prime())




reset()
print("""\
# ****************************************************************************
# CRIBLE QUADRATIQUE
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

n=2886

# Code pour l'EXERCICE

def cribleQuadratique (n):
    return  n

# # Affichage des resultats

cribleQuadratique (n)



