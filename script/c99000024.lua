--HA(È¦¸®¿£Á©) ÇÏ´ÃÀÇ ¿©¿Õ ¿ì¶ó´©½º Äý Ver.2
function c99000024.initial_effect(c)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetCondition(c99000024.dscon)
	e2:SetValue(c99000024.efilter)
	c:RegisterEffect(e2)
	--immune 
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c99000024.dscon)
	e3:SetValue(c99000024.eefilter)
	c:RegisterEffect(e3)
	--cannot release
	local ea=Effect.CreateEffect(c)
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	ea:SetRange(LOCATION_MZONE)
	ea:SetCode(EFFECT_UNRELEASABLE_SUM)
	ea:SetValue(1)
	c:RegisterEffect(ea)
	local eb=ea:Clone()
	eb:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(eb)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(99000024,0))
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetTarget(c99000024.target)
	e4:SetOperation(c99000024.operation)
	c:RegisterEffect(e4)
	--atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EFFECT_UPDATE_ATTACK)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetValue(c99000024.atkval)
	c:RegisterEffect(e5)
	local e7=e5:Clone()
	e7:SetCode(EFFECT_UPDATE_DEFENCE)
	c:RegisterEffect(e7)
	--spsummon limit
	local ee=Effect.CreateEffect(c)
	ee:SetType(EFFECT_TYPE_SINGLE)
	ee:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	ee:SetCode(EFFECT_SPSUMMON_CONDITION)
	ee:SetValue(c99000024.splimit)
	c:RegisterEffect(ee)
end
function c99000024.dscon(e)
	return e:GetHandler():GetOverlayCount()~=0
end
function c99000024.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(99000025)
end
function c99000024.efilter(e,te)
	if te:IsActiveType(TYPE_MONSTER) and te:IsHasType(0x7e0) then
		local lv=e:GetHandler():GetRank()
		local ec=te:GetHandler()
		if ec:IsType(TYPE_XYZ) then
			return ec:GetOriginalRank()<lv
		else
			return ec:GetOriginalLevel()<lv
		end
	end
	return false
end
function c99000024.eefilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c99000024.filter(c)
	return c:IsFaceup()
end
function c99000024.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsOnField() and c99000024.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c99000024.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c99000024.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
end
function c99000024.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCountLimit(1)
		e1:SetValue(c99000024.valcon)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c99000024.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
function c99000024.atkval(e,c)
	local tp=c:GetControler()
	local lv=0
	for i=0,4 do
		local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,i)
		if tc and tc:IsFaceup() and tc:IsType(TYPE_EFFECT) then lv=lv+tc:GetLevel()
			if tc:IsType(TYPE_XYZ) then lv=lv+tc:GetRank()
			else lv=lv+tc:GetLevel() end
		end
	end
	return lv*-20
end