import pandas as pd

df = pd.read_csv("FoodTaxesAbril.csv")
#print(df)

anios = df[(df['Year']>= 2004) & (df['Year']<=2014)]


'''print("Total de estados en USA:\n")
print(anios["State Abbr."].nunique())

print(" estados en USA:\n")
print(anios["State Abbr."].unique())'''



# Lista de estados que pertenecen a la región "West"
region_west_states = ['AK', 'CA', 'CO', 'HI', 'ID', 'MT', 'NV', 'OR', 'UT', 'WA', 'WY']
midwest_states = ['IL', 'IN', 'IA', 'KS', 'MI', 'MN', 'MO', 'NE', 'ND', 'OH', 'SD', 'WI']
northeast_states = ['CT', 'ME', 'MA', 'NH', 'NJ', 'NY', 'PA', 'RI', 'VT']
southeast_states = ['AL', 'FL', 'GA', 'KY', 'MS', 'NC', 'SC', 'TN', 'VA', 'WV']
southwest_states = ['AZ', 'NM', 'OK', 'TX']




# Crear un diccionario de mapeo para asignar regiones a los estados
region_mapping = {
    **{state: 'Midwest' for state in midwest_states},
    **{state: 'Northeast' for state in northeast_states},
    **{state: 'Southeast' for state in southeast_states},
    **{state: 'Southwest' for state in southwest_states}
}
# Asignar la región "West" a los estados correspondientes en una nueva columna "Region"
anios['Region'] = anios['State Abbr.'].map(region_mapping)
#anios['Region'] = anios['State Abbr.'].map(region_mapping1)
"""anios['Region'] = anios['State Abbr.'].map(region_mapping2)
anios['Region'] = anios['State Abbr.'].map(region_mapping3)
anios['Region'] = anios['State Abbr.'].map(region_mapping4)"""



print(anios)