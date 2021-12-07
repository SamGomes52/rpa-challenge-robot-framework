*** Settings ***
Documentation     Resolve o desafio Input Forms - RPA Challenge.
Library    RPA.Excel.Files
Library    RPA.HTTP
Library    RPA.Browser.Selenium

*** Keywords ***
Baixa a planilha
    ${url}=    Set Variable    https://www.rpachallenge.com/assets/downloadFiles/challenge.xlsx
    RPA.HTTP.Download    ${url}    overwrite=True

Le a planilha
    RPA.Excel.Files.Open Workbook    challenge.xlsx
    ${planilha}=    Read Worksheet As Table    header=True
    Close Workbook

    [Return]    ${planilha}

Abre o site RPA Challenge
    Open Available Browser    https://www.rpachallenge.com/    maximized=True

Envia dados da planilha
    [Arguments]    ${planilha}

    Click Button When Visible    //button

    FOR    ${linha}    IN    @{planilha}
        Input Text When Element Is Visible    css:input[ng-reflect-name="labelEmail"]    ${linha}[Email]
        Input Text    css:input[ng-reflect-name="labelLastName"]    ${linha}[Last Name]
        Input Text    css:input[ng-reflect-name="labelPhone"]    ${linha}[Phone Number]
        Input Text    css:input[ng-reflect-name="labelCompanyName"]    ${linha}[Company Name]
        Input Text    css:input[ng-reflect-name="labelRole"]    ${linha}[Role in Company]
        Input Text    css:input[ng-reflect-name="labelFirstName"]    ${linha}[First Name]
        Input Text    css:input[ng-reflect-name="labelAddress"]    ${linha}[Address]

        Click Element    css:input[value="Submit"]
    END


*** Tasks ***
Envia formulario usando dados da planilha
    Baixa a planilha
    ${planilha}=    Le a planilha
    Abre o site RPA Challenge
    Envia dados da planilha    ${planilha}
