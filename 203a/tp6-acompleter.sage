print("""\
# *************************************************************************** #
# *************************************************************************** #
# TP6 : BASES DE GROEBNER ET SYSTEMES POLYNOMIAUX MULTIVARIES                 #
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
#  FONCTIONS DE SAGEMATH
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

MPol.<x,y,z> = PolynomialRing(QQ,3, order='lex')
f = 2*x^2*y+7*z^3

# Code pour l'EXERCICE

print(x<y^2)
print(f.lt())
print(f.lc())
print(f.lm())

reponse  ="votre reponse ici"

# # Affichage des resultats

print("\n$1/ ", reponse)

reset()
print("""\
# ****************************************************************************
# DIVISION MULTIVARIEE
# ****************************************************************************
""")




# Donnees de l'enonce de l'exercice

MPol.<x,y> = PolynomialRing(QQ,2, order='lex')
f  = -x^7 + x^6*y + 2*x^5 - 2*x^4*y - 5*x^2 + 3*x*y^3 + 5*x*y + 11*y^3 + 10 
f1 = x*y^2+2*y^2
f2 = x^5+5

# Code pour l'EXERCICE

def myDivision(f,F):
    MPol = f.parent()
    n = MPol.ngens()
    s = len(F)
    Q = [MPol(0)]*s
    r = f
    assert(f==sum(q*g for q,g in zip(Q,F) )+r)
    return Q,r

# # Affichage des resultats

print("\n$ ",  myDivision(f,[f1,f2]))

reset()
print("""\
# ****************************************************************************
# BASE DE GROEBNER
# ****************************************************************************
""")

# Donnees de l'enonce de l'exercice

MPol.<x,y,z> = PolynomialRing(QQ,3, order='lex')
f1 = x^2-y
f2 = x*y-z
f3 = z^4+x*y

# Code pour l'EXERCICE

def myGroebner(F):
    return F
    
def myRedGroebner(F):
    return F

# # Affichage des resultats

print("\n$1/ ",myGroebner([f1,f2,f3]))
print("\n$2/ ",myRedGroebner([f1,f2,f3]))





reset()
print("""\
# ****************************************************************************
# APPARTENANCE A UN IDEAL
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

MPol.<x,y,z> = PolynomialRing(QQ,3, order='lex')
f1 = x*y-y^2
f2 = x^3-z^2
I = Ideal([f1,f2])
f = -4*x^2*y^2*z^2 + y^6 + 3*z^5

# Code pour l'EXERCICE

test1 = f in I
test2 = false  # A ECRIRE VOUS-MEME


# # Affichage des resultats

print("\n$ Test de Sage ",test1)
print("\n$ Test de personnel ",test2)


reset()
print("""\
# ****************************************************************************
# RESOLUTION D'UN SYSTEME
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


MPol.<x,y> = PolynomialRing(QQ,2) # QUEL ORDRE DEVEZ-VOUS CHOISIR ?
f = (y^2+6)*(x-1) - y*(x^2 + 1)
g = (x^2+6)*(y-1) - x*(y^2 + 1)
 

# Code pour l'EXERCICE

base = [] # Vous pouvez utiliser la fonction adhoc de sage
          # pour calculer la base Groebner
racines_y = [] # 
racines  = [(0,0)]

Gf = implicit_plot(f,(x,0,6),(y,0,6),color='red') 
Gg = implicit_plot(g,(x,0,6),(y,0,6),color='blue')  
Gp = point2d(racines,color='green')

# # Affichage des resultats

print("\n$1/  Une base de Groebner de [f,g] est", base)
print("\n$2/  Les valeurs de y sont", racines_y)
print("\n$4/  Les valeurs de (x,y) sont", racines)
print("\n$4/")
show(Gf+Gg+Gp)




reset()
print("""\
# ****************************************************************************
# OPTIMISATION
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


MPol.<x,y,lamb> = PolynomialRing(QQ,3) # QUEL ORDRE DEVEZ-VOUS CHOISIR ?
f = x^2*y  - 2*x*y + y + 1
g = x^2 + y^2 - 1


# Code pour l'EXERCICE

syst = []
base = []
racines = []


# # Affichage des resultats


print("\n$1/  On doit resoudre le systeme", syst)
print("\n$2/  dont une base de Groebner est", base)
print("\n$4/  Les valeurs de (x,y) sont", racines)





reset()
print("""\
# ****************************************************************************
# MANIPULATIONS ALGEBRIQUES
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice

# Code pour l'EXERCICE


# # Affichage des resultats

print("\n$1/ ")

reset()
print("""\
# ****************************************************************************
# OVALES DE DESCARTES
# ****************************************************************************
""")


# Donnees de l'enonce de l'exercice


# Code pour l'EXERCICE

eq = 0

# # Affichage des resultats

print("\n$ L'équation est ",eq)
